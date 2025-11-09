#ifndef STORAGE_MANAGER_H
#define STORAGE_MANAGER_H

#include <string>
#include <memory>
#include <cstdint>

class StorageSink {
public:
    virtual ~StorageSink() = default;

    /**
     * 写入数据
     * @param data 数据指针
     * @param size 数据大小
     * @param pts 时间戳
     * @return 是否写入成功
     */
    virtual bool write(const uint8_t* data, size_t size, int64_t pts) = 0;

    /**
     * 读取数据
     * @param data 数据缓冲区
     * @param size 要读取的数据大小
     * @param offset 偏移量
     * @return 是否读取成功
     */
    virtual bool read(uint8_t* data, size_t size, int64_t offset) = 0;

    /**
     * 删除文件
     * @param path 文件路径
     * @return 是否删除成功
     */
    virtual bool delete_file(const std::string& path) = 0;

    /**
     * 获取可用空间
     * @return 可用空间大小（字节）
     */
    virtual uint64_t get_free_space() const = 0;
};

class StorageManager {
public:
    virtual ~StorageManager() = default;

    /**
     * 创建存储后端实例
     * @param backend_type 后端类型 (local, s3, nfs)
     * @param config 配置参数
     * @return 存储后端实例
     */
    virtual std::unique_ptr<StorageSink> create_storage_sink(
        const std::string& backend_type, 
        const std::string& config) = 0;

    /**
     * 注册存储后端
     * @param name 后端名称
     * @param sink 存储后端实例
     */
    virtual void register_storage_sink(const std::string& name, std::unique_ptr<StorageSink> sink) = 0;

    /**
     * 获取存储后端
     * @param name 后端名称
     * @return 存储后端实例
     */
    virtual std::unique_ptr<StorageSink> get_storage_sink(const std::string& name) = 0;
};

#endif // STORAGE_MANAGER_H