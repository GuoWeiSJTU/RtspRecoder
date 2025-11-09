#ifndef PLUGIN_MANAGER_H
#define PLUGIN_MANAGER_H

#include <string>
#include <memory>
#include <unordered_map>
#include <vector>

class MediaSource;

class PluginManager {
public:
    struct PluginInfo {
        std::string name;
        std::string version;
        std::string author;
        std::string description;
        std::vector<std::string> supported_protocols;
    };

    virtual ~PluginManager() = default;

    /**
     * 加载插件
     * @param plugin_path 插件文件路径
     * @return 是否加载成功
     */
    virtual bool load_plugin(const std::string& plugin_path) = 0;

    /**
     * 卸载插件
     * @param plugin_name 插件名称
     * @return 是否卸载成功
     */
    virtual bool unload_plugin(const std::string& plugin_name) = 0;

    /**
     * 创建媒体源实例
     * @param protocol 协议类型
     * @return 媒体源实例
     */
    virtual std::unique_ptr<MediaSource> create_media_source(const std::string& protocol) = 0;

    /**
     * 获取插件信息
     * @param plugin_name 插件名称
     * @return 插件信息
     */
    virtual PluginInfo get_plugin_info(const std::string& plugin_name) const = 0;

    /**
     * 获取所有已加载插件名称
     * @return 插件名称列表
     */
    virtual std::vector<std::string> list_loaded_plugins() const = 0;
};

// 插件创建和销毁函数原型
extern "C" {
    typedef MediaSource* (*create_source_func)();
    typedef void (*destroy_source_func)(MediaSource*);
}

#endif // PLUGIN_MANAGER_H