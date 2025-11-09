#ifndef CONFIG_MANAGER_H
#define CONFIG_MANAGER_H

#include <string>
#include <memory>
#include <unordered_map>
#include <vector>
#include "recorder_controller.h"

// 前向声明
namespace YAML {
    class Node;
}

struct StreamConfig {
    std::string id;
    std::string url;
    std::string username;
    std::string password;
    RecordingConfig record_config;
};

struct GlobalConfig {
    std::string log_level = "info";
    size_t max_concurrent_streams = 10;
    std::string default_storage_path = "./recordings";
    std::unordered_map<std::string, StreamConfig> streams;
};

class ConfigManager {
public:
    static ConfigManager& instance();
    
    bool load_from_file(const std::string& file_path);
    bool save_to_file(const std::string& file_path) const;
    
    const GlobalConfig& get_config() const;
    void set_config(const GlobalConfig& config);
    
    bool add_stream(const StreamConfig& stream);
    bool remove_stream(const std::string& stream_id);
    bool update_stream(const std::string& stream_id, const StreamConfig& stream);
    
    // 支持配置热更新
    void enable_hot_reload(bool enable);
    bool is_hot_reload_enabled() const;

private:
    ConfigManager() = default;
    ~ConfigManager() = default;
    ConfigManager(const ConfigManager&) = delete;
    ConfigManager& operator=(const ConfigManager&) = delete;
    
    bool parse_yaml(const YAML::Node& node, GlobalConfig& config);
    void validate_config(GlobalConfig& config) const;
    
    GlobalConfig config_;
    bool hot_reload_enabled_ = false;
};

#endif // CONFIG_MANAGER_H