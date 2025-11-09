#ifndef RECORDER_CONTROLLER_H
#define RECORDER_CONTROLLER_H

#include <string>
#include <chrono>
#include <memory>

// 前向声明
class MediaSource;
struct AVPacket;

enum class RecordMode {
    AUDIO_VIDEO,  // 音视频同步录制
    VIDEO_ONLY,   // 仅录制视频
    AUDIO_ONLY    // 仅录制音频
};

enum class RecorderStatus {
    STOPPED,      // 已停止
    RECORDING,    // 录制中
    PAUSED,       // 已暂停
    RECONNECTING  // 重连中
};

struct RecordingConfig {
    std::string stream_id;
    std::string format = "mp4";  // mp4, mkv, ts
    RecordMode mode = RecordMode::AUDIO_VIDEO;
    std::chrono::seconds segment_duration{300};  // 5分钟
    size_t segment_size = 1024 * 1024 * 1024;    // 1GB
    bool loop_record = false;
    std::string storage_backend = "local";
    std::string encrypt_mode = "none";  // none, aes-128-cbc, sm4
};

class RecorderController {
public:
    virtual ~RecorderController() = default;

    /**
     * 开始录制
     * @param source 媒体源
     * @param config 录制配置
     * @return 是否启动成功
     */
    virtual bool start_recording(std::unique_ptr<MediaSource> source, const RecordingConfig& config) = 0;

    /**
     * 停止录制
     * @param stream_id 流ID
     * @return 是否停止成功
     */
    virtual bool stop_recording(const std::string& stream_id) = 0;

    /**
     * 暂停录制
     * @param stream_id 流ID
     * @return 是否暂停成功
     */
    virtual bool pause_recording(const std::string& stream_id) = 0;

    /**
     * 恢复录制
     * @param stream_id 流ID
     * @return 是否恢复成功
     */
    virtual bool resume_recording(const std::string& stream_id) = 0;

    /**
     * 获取录制状态
     * @param stream_id 流ID
     * @return 当前录制状态
     */
    virtual RecorderStatus get_status(const std::string& stream_id) const = 0;

    /**
     * 更新录制配置
     * @param stream_id 流ID
     * @param config 新的录制配置
     * @return 是否更新成功
     */
    virtual bool update_config(const std::string& stream_id, const RecordingConfig& config) = 0;
};

#endif // RECORDER_CONTROLLER_H