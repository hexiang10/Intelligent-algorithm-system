<template>
  <div class="body">
    <h1 >人脸探测</h1>
    <br/>
      <div class="video-box" style="margin: auto">
        <video id="video" width="330" height="250" preload autoPlay loop muted></video>
        <canvas id="canvas" width="320" height="240"></canvas>
      </div>
      <canvas id="screenshotCanvas" width="320" height="240"></canvas>
      <br/>
      <canvas id="CaptureCanvas" :width="captureWidth" :height="captureHeight"></canvas>
    <br/>
    <br/>
    <el-button type="danger" round @click="end" style="margin-top: 10px ">停止探测</el-button>
    <el-button type="success" round @click="goon" style="margin-top: 10px ">继续探测</el-button>
    <el-button type="primary" round  style="margin-top: 10px ">提交人脸</el-button>
    <br/>
    <br/>
    <div class="face" >
      <h1>人脸捕获</h1>
      <img :src="captureImg" >
      <!--      <img :src="base64Img" >-->
    </div>

    </div>

</template>


<script>
import '@/assets/tracking/build/tracking-min.js'
import '@/assets/tracking/build/data/face-min.js'


export default {
  data() {
    return {
      base64Img: '',
      captureImg: '',
      captureWidth: 0,
      captureHeight: 0,
      video: null,
      screenshotCanvas: null,
      CaptureCanvas: null,
      uploadLock: true // 上传锁
    }
  },
  mounted() {
    this.init()
  },
  methods: {
    // 初始化设置
    init() {
      this.video = document.getElementById('video')
      this.screenshotCanvas = document.getElementById('screenshotCanvas')
      this.CaptureCanvas = document.getElementById('CaptureCanvas')
      let canvas = document.getElementById('canvas')
      let context = canvas.getContext('2d')

      // 固定写法
      let tracker = new window.tracking.ObjectTracker('face')
      tracker.setInitialScale(4)
      tracker.setStepSize(2)
      tracker.setEdgesDensity(0.1)
      this.trackerTask = window.tracking.track('#video', tracker, {
        camera: true
      })

      let _this = this
      tracker.on('track', function(event) {

        // 检测出人脸 绘画人脸位置
        context.clearRect(0, 0, canvas.width, canvas.height)
        event.data.forEach(function(rect) {
          context.strokeStyle = '#0764B7'
          context.strokeRect(rect.x, rect.y, rect.width, rect.height)
          context.font = '11px Helvetica';
          context.fillStyle = "#fff";
          context.fillText('人脸目标 ', rect.x, rect.y);
          context.fillText('x: ' + rect.x + 'px', rect.x + rect.width + 5, rect.y + 11);
          context.fillText('y: ' + rect.y + 'px', rect.x + rect.width + 5, rect.y + 22);

          // 上传图片
          // _this.uploadLock &&
          _this.screenshotAndUpload(rect)
        })
      })
    },
    // 上传图片
    screenshotAndUpload(rect) {
      // 上锁避免重复发送请求
      this.uploadLock = false

      // 绘制当前帧图片转换为base64格式
      let canvas = this.screenshotCanvas
      let canvas2 = this.CaptureCanvas
      let video = this.video
      let ctx = canvas.getContext('2d')
      let ctx2 = canvas2.getContext('2d')
      ctx.clearRect(0, 0, canvas.width, canvas.height)
      ctx2.clearRect(0, 0, canvas.width, canvas.height)
      ctx.drawImage(video, 0, 0, canvas.width, canvas.height)
      var dataImg = ctx.getImageData(rect.x, rect.y, rect.width, rect.height);
      ctx2.putImageData(dataImg, 0, 0, 0, 0, rect.width, rect.height);
      this.captureWidth = rect.width
      this.captureHeight = rect.height
      // let base64Img = canvas.toDataURL('image/jpeg')
      // this.base64Img = base64Img;
      let captureImg = canvas2.toDataURL('image/jpeg')
      this.captureImg = captureImg;
      // 使用 base64Img 请求接口即可
      // console.log('base64Img:', base64Img)

      // 请求接口成功以后打开锁
      // this.uploadLock = true;
    },
    end() {
      // 停止侦测
      this.trackerTask.stop();
      // 关闭摄像头
      this.trackerTask.closeCamera();
    },
    goon(){
      this.init()
    }
  },
  destroyed() {
    // 停止侦测
    this.trackerTask.stop();
    // 关闭摄像头
    this.trackerTask.closeCamera();
  },
}
</script>

<style scoped>

.body {
  font-family: Arial;
  text-align: center;
}
/* 绘图canvas 不需显示隐藏即可 */
#screenshotCanvas {
  display: none;
}
#CaptureCanvas {
  display: none;
}

.video-box {
  position: relative;
  width: 320px;
  height: 240px;
}


video, canvas {
  position: absolute;
  top: 0;
  left: 0;
  border: #000000 5px solid;
}
</style>
