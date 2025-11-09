#ifndef MEDIA_SOURCE_H
#define MEDIA_SOURCE_H

#include <string>
#include <memory>
#include <chrono>

extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libavcodec/packet.h>
#include <libavcodec/codec_par.h>
}

// 前向声明
// struct AVPacket;
// struct AVCodecParameters;

// 智能指针类型定义
using AVPacketPtr = std::unique_ptr<AVPacket, decltype(&av_packet_free)>;

// 认证信息结构
struct AuthInfo {
    std::string username;
    std::string password;
};

// 媒体元数据结构
struct MediaMetadata {
    std::unique_ptr<AVCodecParameters, decltype(&avcodec_parameters_free)> video_codec_params;
    std::unique_ptr<AVCodecParameters, decltype(&avcodec_parameters_free)> audio_codec_params;
    int width = 0;
    int height = 0;
    int sample_rate = 0;
    
    MediaMetadata() 
        : video_codec_params(nullptr, &avcodec_parameters_free),
          audio_codec_params(nullptr, &avcodec_parameters_free) {}
};

class MediaSource {
public:
    virtual ~MediaSource() = default;
    
    /**
     * 连接到媒体源
     * @param url 媒体源地址
     * @param auth 认证信息
     * @return 连接是否成功
     */
    virtual bool connect(const std::string& url, const AuthInfo& auth) = 0;
    
    /**
     * 断开连接
     */
    virtual void disconnect() = 0;
    
    /**
     * 读取媒体包
     * @param packet 输出参数，读取到的媒体包
     * @return 读取是否成功
     */
    virtual bool read_packet(AVPacketPtr& packet) = 0;
    
    /**
     * 获取媒体元数据
     * @return 媒体元数据
     */
    virtual MediaMetadata get_metadata() const = 0;
    
    /**
     * 设置超时时间
     * @param timeout 超时时间
     */
    virtual void set_timeout(std::chrono::milliseconds timeout) = 0;
};

#endif // MEDIA_SOURCE_H