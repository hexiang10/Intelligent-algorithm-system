<template>
  <div class="body" >
    <h1>图片边缘提取</h1>
    <el-button type="success"  @click="recognize" >开始处理</el-button>
    <br/>
    <h2 v-if="isRecognize">原图</h2>
    <img :src="imgUrl" style="margin-top: 10px" >
    <h2 v-if="isRecognize">边缘提取</h2>
    <img :src="Gaussian_Noise" style="margin-top: 10px" >
<!--    <h2 v-if="isRecognize">均值转化处理</h2>-->
<!--    <img :src="Gaussian_Blur" style="margin-top: 10px" >-->
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
      :on-change="fileChange"
      :file-list="fileList"
      :multiple="false"
      :limit="photoNum"
      list-type="picture"
    >
      <el-button  type="primary">上传图片</el-button>
      <div slot="tip" class="el-upload__tip">
        只能上传jpg/png/jpeg文件，且不超过10MB
      </div>
    </el-upload>
    <br/>
    <h3 v-if="isRecognize">{{ resultInfo}}</h3>
  </div>
</template>

<script>
import {upload ,getImg} from '@/api/ai/utils/AIUtil'

export default {
  Name: "CANNY",
  data() {
    return {
      imgUrl:  require("@/assets/images/canny.jpeg") ,
      isRecognize: false,
      fileList: [],
      resultInfo:'',
      filePath: '',
      photoNum: 1,
      isUpload: false,
      Gaussian_Noise:'',
      Gaussian_Blur:''
    };
  },
  methods: {
    beforeUpload(file){
      const isJPG = file.type === 'image/jpeg';
      const isPNG = file.type === 'image/png';
      const isJPEG = file.type === 'image/jpeg';
      const isLt10M = file.size / 1024 / 1024 < 10;
      if (!isJPG&&!isPNG&&!isJPEG) {
        this.$message.error('上传的图片只能是 JPG|PNG|JPEG 格式');
      }
      if (!isLt10M) {
        this.$message.error('上传的图片大小不能超过 10MB!');
      }
    },

    uploadHttpRequest(file,fileList) {
      let formData = new FormData();
      formData.append('file', file.file);
      upload(formData).then(res=>{
        if(res.msg==='error'){
          this.$message.error(res.data);
        }
        else {
          this.$message.success(res.msg);
          let src = res.data.photo;
          src = src == null ? '' : 'data:image/png;base64,' + src
          this.imgUrl = src
          this.filePath = res.data.uploadPath;
        }})
    },

    handleRemove(file, fileList) {
      this.$message.success("已删除上传文件")
    },
    layerView() {
      if(!this.isRecognize) {
        this.$message.error("图片未开始识别，无法查看结果！");
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
      this.submitUpload();
      this.fileList = [];
      this.Gaussian_Noise='';
      this.Gaussian_Blur='';
      this.isRecognize=false;
      this.isUpload=true;
    },
    // 点击上传：手动上传到服务器，此时会触发组件的http-request
    submitUpload() {
      this.$refs.upload.submit()
    },

    recognize(){
      if(!this.isUpload){
        this.$message.error("未上传图片！");
        return;
      }
      const loading = this.$loading({
        lock: true,
        text: '正在处理中......',
        spinner: 'el-icon-loading',
        background: 'rgba(0, 0, 0, 0.7)'
      });
      getImg('canny',this.filePath).then(res=>{
        if(res.msg==='error'){
          this.$message.error(res.data);
        }else {
          this.$message.success(res.msg);
          console.log(res)
          let src = res.data.canny
          src = src == null ? '' : 'data:image/png;base64,' + src
          this.Gaussian_Noise = src;
          // src = res.data.pyrMeanShift;
          // src = src == null ? '' : 'data:image/png;base64,' + src
          // this.Gaussian_Blur = src;
          this.isRecognize=true;
          loading.close();
        }
      }).catch(res=>{
        loading.close();
      })
      setTimeout(()=>{
        loading.close();
      },3000)
    }
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
