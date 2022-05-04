<template>
  <div class="body" >
    <h1>Face Recognition</h1>
    <el-button type="success"  @click="submitUpload" >开始识别</el-button>
    <br/>
    <h3 v-if="isRecognize">{{ resultInfo}}</h3>
    <img :src="imgUrl" style="margin-top: 10px">
    <br/>
    <br/>
    <el-upload
      class="upload-demo"
      action=""
      ref="upload"
      accept=".jpg, .png, .jpeg"
      :http-request="uploadHttpRequest"
      :before-upload="beforeUpload"
      :auto-upload="false"
      :on-remove="handleRemove"
      :on-preview="handlePreview"
      :on-change="fileChange"
      :file-list="fileList"
      :multiple="false"
      list-type="picture"
    >
      <el-button  type="primary">上传图片</el-button>
      <div slot="tip" class="el-upload__tip">
        只能上传jpg/png/jpeg文件，且不超过10MB
      </div>
    </el-upload>
  </div>
</template>

<script>
import { upload ,getImg } from '@/api/ai/yolo'

export default {
  Name: "YOLO",
  data() {
    return {
      imgUrl:  require("@/assets/images/yolobg.jpg") ,
      isRecognize: false,
      fileList: [],
      resultInfo:''
    };
  },
  methods: {
    beforeUpload(file){
        const isJPG = file.type === 'image/jpeg';
        const isPNG = file.type === 'image/png';
        const isJPEG = file.type === 'image/jpeg';
        const isLt10M = file.size / 1024 / 1024 < 10;
        if (!isJPG&&!isPNG&&!isJPEG) {
          this.$message.error('上传头像图片只能是 JPG|PNG|JPEG 格式');
        }
        if (!isLt10M) {
          this.$message.error('上传头像图片大小不能超过 10MB!');
        }
    },

    uploadHttpRequest(file,fileList) {
      let formData = new FormData();
      formData.append('file', file.file);
      const loading = this.$loading({
        lock: true,
        text: '正在识别中......',
        spinner: 'el-icon-loading',
        background: 'rgba(0, 0, 0, 0.7)'
      });
      upload(formData).then(res=>{
        if(res.msg=='error'){
          this.$message.error(res.data);
          loading.close();
        }
        else {
          this.$message.success(res.msg);
          console.log(res.data);
          this.resultInfo = '识别结果：'+res.data.target+' => '+res.data.results;
          getImg(res.data.filePath).then(res=>{
            let src = res.data
            src = src == null ? '' : 'data:image/png;base64,' + src
            this.imgUrl = src
            this.isRecognize=true;
            loading.close();
          }).catch(res=>{
            loading.close();
          })


        }
      })
      setTimeout(()=>{
        loading.close();
      },3000)
    },

    handleRemove(file, fileList) {
      this.$message.success("已取消上传")
    },
    handlePreview(file) {
      if(!this.isRecognize) {
        this.$message.error("图片未上传识别，无法查看结果！");
        return;
      }
      const h = this.$createElement;
      this.$notify({
        title: '识别结果',
        message: h('i', { style: 'color: teal'}, this.resultInfo)
      });
    },
    // 文件发生改变
    fileChange(file,fileList) {
        if (fileList.length > 0) {
            this.fileList = [fileList[fileList.length - 1]] // 展示最后一次选择的文件
        }
        this.isRecognize=false;
        this.imgUrl = require("@/assets/images/yolobg.jpg")
  },
  // 点击上传：手动上传到服务器，此时会触发组件的http-request
    submitUpload() {
        this.$refs.upload.submit()
    },
}
};
</script>

<style scoped>
.body {
  font-family: Arial;
  text-align: center;
}
canvas {
  width: 300px;
  height: 300px;
  border: 2px solid black;
  margin: 0 auto;
  display: block;
  border-radius: 10px;
}
</style>
