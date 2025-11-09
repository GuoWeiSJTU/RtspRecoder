#include "config_manager.h"
#include <yaml-cpp/yaml.h>
#include <fstream>
#include <iostream>
#include <sstream>

ConfigManager& ConfigManager::instance() {
    static ConfigManager instance;
    return instance;
}

bool ConfigManager::load_from_file(const std::string& file_path) {
    try {
        YAML::Node config = YAML::LoadFile(file_path);
        GlobalConfig new_config;
        
        if (parse_yaml(config, new_config)) {
            validate_config(new_config);
            config_ = std::move(new_config);
            return true;
        }
    } catch (const YAML::Exception& e) {
        std::cerr << "Failed to load config file: " << e.what() << std::endl;
        return false;
    } catch (const std::exception& e) {
        std::cerr << "Error parsing config file: " << e.what() << std::endl;
        return false;
    }
    
    return false;
}

bool ConfigManager::save_to_file(const std::string& file_path) const {
    try {
        YAML::Emitter out;
        out << YAML::BeginMap;
        
        // 输出全局配置
        out << YAML::Key << "log_level" << YAML::Value << config_.log_level;
        out << YAML::Key << "max_concurrent_streams" << YAML::Value << config_.max_concurrent_streams;
        out << YAML::Key << "default_storage_path" << YAML::Value << config_.default_storage_path;
        
        // 输出流配置
        out << YAML::Key << "streams" << YAML::Value << YAML::BeginSeq;
        for (const auto& [id, stream_config] : config_.streams) {
            out << YAML::BeginMap;
            out << YAML::Key << "id" << YAML::Value << stream_config.id;
            out << YAML::Key << "url" << YAML::Value << stream_config.url;
            out << YAML::Key << "username" << YAML::Value << stream_config.username;
            out << YAML::Key << "password" << YAML::Value << stream_config.password;
            
            // 输出录制配置
            const auto& record_config = stream_config.record_config;
            out << YAML::Key << "record_config" << YAML::Value << YAML::BeginMap;
            out << YAML::Key << "format" << YAML::Value << record_config.format;
            out << YAML::Key << "segment_duration" << YAML::Value << record_config.segment_duration.count();
            out << YAML::Key << "segment_size" << YAML::Value << record_config.segment_size;
            out << YAML::Key << "storage_backend" << YAML::Value << record_config.storage_backend;
            out << YAML::EndMap;
            
            out << YAML::EndMap;
        }
        out << YAML::EndSeq;
        out << YAML::EndMap;
        
        std::ofstream fout(file_path);
        fout << out.c_str();
        return fout.good();
    } catch (const std::exception& e) {
        std::cerr << "Error saving config file: " << e.what() << std::endl;
        return false;
    }
}

const GlobalConfig& ConfigManager::get_config() const {
    return config_;
}

void ConfigManager::set_config(const GlobalConfig& config) {
    config_ = config;
}

bool ConfigManager::add_stream(const StreamConfig& stream) {
    auto result = config_.streams.emplace(stream.id, stream);
    return result.second;
}

bool ConfigManager::remove_stream(const std::string& stream_id) {
    return config_.streams.erase(stream_id) > 0;
}

bool ConfigManager::update_stream(const std::string& stream_id, const StreamConfig& stream) {
    auto it = config_.streams.find(stream_id);
    if (it != config_.streams.end()) {
        it->second = stream;
        return true;
    }
    return false;
}

void ConfigManager::enable_hot_reload(bool enable) {
    hot_reload_enabled_ = enable;
}

bool ConfigManager::is_hot_reload_enabled() const {
    return hot_reload_enabled_;
}

bool ConfigManager::parse_yaml(const YAML::Node& node, GlobalConfig& config) {
    if (!node.IsMap()) {
        std::cerr << "Config file root should be a map" << std::endl;
        return false;
    }
    
    // 解析全局配置
    if (node["log_level"]) {
        config.log_level = node["log_level"].as<std::string>();
    }
    
    if (node["max_concurrent_streams"]) {
        config.max_concurrent_streams = node["max_concurrent_streams"].as<size_t>();
    }
    
    if (node["default_storage_path"]) {
        config.default_storage_path = node["default_storage_path"].as<std::string>();
    }
    
    // 解析流配置
    if (node["streams"] && node["streams"].IsSequence()) {
        for (const auto& stream_node : node["streams"]) {
            if (!stream_node.IsMap()) continue;
            
            StreamConfig stream_config;
            stream_config.id = stream_node["id"].as<std::string>();
            stream_config.url = stream_node["url"].as<std::string>();
            
            if (stream_node["username"]) {
                stream_config.username = stream_node["username"].as<std::string>();
            }
            
            if (stream_node["password"]) {
                stream_config.password = stream_node["password"].as<std::string>();
            }
            
            // 解析录制配置
            if (stream_node["record_config"] && stream_node["record_config"].IsMap()) {
                const auto& record_node = stream_node["record_config"];
                auto& record_config = stream_config.record_config;
                
                if (record_node["format"]) {
                    record_config.format = record_node["format"].as<std::string>();
                }
                
                if (record_node["segment_duration"]) {
                    record_config.segment_duration = std::chrono::seconds(
                        record_node["segment_duration"].as<int>());
                }
                
                if (record_node["segment_size"]) {
                    record_config.segment_size = record_node["segment_size"].as<size_t>();
                }
                
                if (record_node["storage_backend"]) {
                    record_config.storage_backend = record_node["storage_backend"].as<std::string>();
                }
            }
            
            config.streams.emplace(stream_config.id, std::move(stream_config));
        }
    }
    
    return true;
}

void ConfigManager::validate_config(GlobalConfig& config) const {
    // 确保最大并发流数在合理范围内
    if (config.max_concurrent_streams == 0) {
        config.max_concurrent_streams = 10; // 默认值
    }
    
    // 确保存储路径不为空
    if (config.default_storage_path.empty()) {
        config.default_storage_path = "./recordings";
    }
}