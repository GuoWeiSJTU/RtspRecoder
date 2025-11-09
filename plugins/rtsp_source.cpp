#include "media_source.h"
#include <asio.hpp>
#include <string>
#include <chrono>

// Note: ASIO is managed by Conan in this project

// RTSP源实现 - 第一周基础版本
class RtspSource : public MediaSource {
private:
    asio::io_context io_context_;
    std::string url_;
    AuthInfo auth_info_;
    std::chrono::milliseconds timeout_{5000};
    bool connected_ = false;

public:
    RtspSource() = default;
    ~RtspSource() override {
        disconnect();
    }

    bool connect(const std::string& url, const AuthInfo& auth) override {
        url_ = url;
        auth_info_ = auth;
        
        // 第一周实现基础连接逻辑
        // 实际实现中，这里会建立RTSP连接
        connected_ = true;
        return true;
    }

    void disconnect() override {
        connected_ = false;
        // 实际实现中，这里会断开RTSP连接
    }

    bool read_packet(AVPacketPtr& packet) override {
        if (!connected_) {
            return false;
        }
        
        // 第一周实现基础包读取逻辑
        // 实际实现中，这里会从RTSP流中读取RTP包并转换为AVPacket
        return true;
    }

    MediaMetadata get_metadata() const override {
        MediaMetadata metadata;
        // 实际实现中，这里会从SDP或其他元数据源获取媒体信息
        return metadata;
    }

    void set_timeout(std::chrono::milliseconds timeout) override {
        timeout_ = timeout;
    }
};

// 插件导出函数
extern "C" {
    MediaSource* create_source() {
        return new RtspSource();
    }

    void destroy_source(MediaSource* source) {
        delete source;
    }
}