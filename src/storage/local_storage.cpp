#include "storage_manager.h"
#include <filesystem>
#include <fstream>
#include <iostream>
#include <algorithm>

namespace fs = std::filesystem;

class LocalStorageSink : public StorageSink {
public:
    explicit LocalStorageSink(const std::string& base_path) : base_path_(base_path) {
        // 确保基础路径存在
        if (!fs::exists(base_path_)) {
            fs::create_directories(base_path_);
        }
    }
    
    bool write(const uint8_t* data, size_t size, int64_t pts) override {
        if (!data || size == 0) {
            return false;
        }
        
        try {
            // 创建文件名（使用时间戳）
            std::string filename = std::to_string(pts) + ".dat";
            fs::path file_path = fs::path(base_path_) / filename;
            
            std::ofstream file(file_path, std::ios::binary | std::ios::app);
            if (!file.is_open()) {
                std::cerr << "Failed to open file for writing: " << file_path << std::endl;
                return false;
            }
            
            file.write(reinterpret_cast<const char*>(data), size);
            return file.good();
        } catch (const std::exception& e) {
            std::cerr << "Error writing to local storage: " << e.what() << std::endl;
            return false;
        }
    }
    
    bool read(uint8_t* data, size_t size, int64_t offset) override {
        // 简化实现，实际应用中需要根据offset查找对应的文件
        return false;
    }
    
    bool delete_file(const std::string& path) override {
        try {
            fs::path file_path = fs::path(base_path_) / path;
            return fs::remove(file_path);
        } catch (const std::exception& e) {
            std::cerr << "Error deleting file: " << e.what() << std::endl;
            return false;
        }
    }
    
    uint64_t get_free_space() const override {
        try {
            auto space = fs::space(base_path_);
            return space.available;
        } catch (const std::exception& e) {
            std::cerr << "Error getting free space: " << e.what() << std::endl;
            return 0;
        }
    }

private:
    std::string base_path_;
};

class LocalStorageManager : public StorageManager {
public:
    std::unique_ptr<StorageSink> create_storage_sink(
        const std::string& backend_type,
        const std::string& config) override {
        
        if (backend_type != "local") {
            return nullptr;
        }
        
        return std::make_unique<LocalStorageSink>(config);
    }
    
    void register_storage_sink(const std::string& name, std::unique_ptr<StorageSink> sink) override {
        // 简化实现
        // 实际实现中应该将sink存储在某种容器中
    }
    
    std::unique_ptr<StorageSink> get_storage_sink(const std::string& name) override {
        // 简化实现
        // 实际实现中应该从容器中查找并返回相应的sink
        return nullptr;
    }
};

// 导出函数
extern "C" {
    StorageManager* create_storage_manager() {
        return new LocalStorageManager();
    }
    
    void destroy_storage_manager(StorageManager* manager) {
        delete manager;
    }
}
