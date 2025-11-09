#include "media_source.h"
#include <asio.hpp>
#include <string>
#include <chrono>
#include <iostream>
#include <sstream>
#include <regex>
#include <memory>

// RTSP源实现 - 第二周完善版本
class RtspSource : public MediaSource {
private:
    asio::io_context io_context_;
    std::string url_;
    AuthInfo auth_info_;
    std::chrono::milliseconds timeout_{5000};
    bool connected_ = false;
    
    // RTSP相关字段
    std::string session_id_;
    std::string cseq_;
    int cseq_counter_ = 1;
    std::string transport_;
    std::string stream_uri_;
    
    // 网络连接
    asio::ip::tcp::socket socket_;
    
public:
    RtspSource() : socket_(io_context_) {}
    
    ~RtspSource() override {
        disconnect();
    }

    bool connect(const std::string& url, const AuthInfo& auth) override {
        url_ = url;
        auth_info_ = auth;
        
        try {
            // 解析RTSP URL
            std::regex rtsp_regex(R"(rtsp://([^:/]+)(?::(\d+))?(/.*))");
            std::smatch match;
            
            if (!std::regex_match(url_, match, rtsp_regex)) {
                std::cerr << "Invalid RTSP URL: " << url_ << std::endl;
                return false;
            }
            
            std::string host = match[1];
            std::string port = match[2].matched ? std::string(match[2]) : "554";
            std::string path = match[3];
            
            // 解析主机地址
            asio::ip::tcp::resolver resolver(io_context_);
            auto endpoints = resolver.resolve(host, port);
            
            // 连接到RTSP服务器
            asio::connect(socket_, endpoints);
            
            // 发送OPTIONS请求
            if (!send_options()) {
                return false;
            }
            
            // 发送DESCRIBE请求
            if (!send_describe()) {
                return false;
            }
            
            // 发送SETUP请求
            if (!send_setup()) {
                return false;
            }
            
            // 发送PLAY请求
            if (!send_play()) {
                return false;
            }
            
            connected_ = true;
            return true;
        } catch (const std::exception& e) {
            std::cerr << "RTSP connection error: " << e.what() << std::endl;
            return false;
        }
    }

    void disconnect() override {
        if (connected_) {
            // 发送TEARDOWN请求
            send_teardown();
            connected_ = false;
        }
        
        if (socket_.is_open()) {
            socket_.close();
        }
    }

    bool read_packet(AVPacketPtr& packet) override {
        if (!connected_) {
            return false;
        }
        
        try {
            // 读取RTP包
            // 这里需要实现实际的RTP包接收和解析逻辑
            // 简化实现，实际应用中需要处理RTP头部和负载数据
            return true;
        } catch (const std::exception& e) {
            std::cerr << "Error reading RTSP packet: " << e.what() << std::endl;
            return false;
        }
    }

    MediaMetadata get_metadata() const override {
        MediaMetadata metadata;
        // 实际实现中，这里会从SDP或其他元数据源获取媒体信息
        return metadata;
    }

    void set_timeout(std::chrono::milliseconds timeout) override {
        timeout_ = timeout;
    }
    
private:
    bool send_options() {
        std::string request = build_rtsp_request("OPTIONS", url_);
        return send_request(request);
    }
    
    bool send_describe() {
        std::string request = build_rtsp_request("DESCRIBE", url_);
        request += "Accept: application/sdp\r\n";
        return send_request(request);
    }
    
    bool send_setup() {
        // 简化实现，实际应用中需要解析SDP并选择合适的传输方式
        std::string track_url = url_ + "/trackID=1"; // 假设视频轨道ID为1
        std::string request = build_rtsp_request("SETUP", track_url);
        request += "Transport: RTP/AVP;unicast;client_port=8000-8001\r\n";
        return send_request(request);
    }
    
    bool send_play() {
        std::string request = build_rtsp_request("PLAY", url_);
        request += "Session: " + session_id_ + "\r\n";
        request += "Range: npt=0.000-\r\n";
        return send_request(request);
    }
    
    bool send_teardown() {
        std::string request = build_rtsp_request("TEARDOWN", url_);
        request += "Session: " + session_id_ + "\r\n";
        return send_request(request);
    }
    
    std::string build_rtsp_request(const std::string& method, const std::string& uri) {
        std::ostringstream request;
        request << method << " " << uri << " RTSP/1.0\r\n";
        request << "CSeq: " << cseq_counter_++ << "\r\n";
        request << "User-Agent: RtspRecorder/1.0\r\n";
        
        // 添加认证信息
        if (!auth_info_.username.empty()) {
            // 简化实现，实际应用中需要实现Basic/Digest认证
            std::string auth_str = auth_info_.username + ":" + auth_info_.password;
            // 这里应该进行Base64编码，简化处理
            request << "Authorization: Basic " << auth_str << "\r\n";
        }
        
        return request.str();
    }
    
    bool send_request(const std::string& request) {
        try {
            // 发送请求
            asio::write(socket_, asio::buffer(request));
            
            // 读取响应（简化实现）
            asio::steady_timer timer(io_context_);
            timer.expires_after(timeout_);
            
            // 实际应用中需要完整解析RTSP响应
            // 这里只是演示基本流程
            char response[1024];
            size_t len = socket_.read_some(asio::buffer(response));
            
            // 解析响应中的关键信息（如Session ID）
            std::string response_str(response, len);
            std::regex session_regex(R"(Session:\s*([^\s;]+))");
            std::smatch session_match;
            if (std::regex_search(response_str, session_match, session_regex)) {
                session_id_ = session_match[1];
            }
            
            return true;
        } catch (const std::exception& e) {
            std::cerr << "Error sending RTSP request: " << e.what() << std::endl;
            return false;
        }
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