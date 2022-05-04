<template>
  <div class="body">

    <h1>手写数字识别</h1>
    <vue-esign ref="esign" :width="300" :height="300" :isCrop="isCrop" :lineWidth="lineWidth" :lineColor="lineColor" :bgColor.sync="bgColor" style="border: 2px solid black;"/>
    <br/>
    <el-button type="primary" round @click="handleReset">清空画板</el-button>
    <el-button type="success" round @click="handleGenerate">开始识别</el-button>
    <br/>
    <h1>{{ resultInfo }}</h1>


  </div>

</template>

<script>
import { uploadImg } from '@/api/ai/handwrite'

export default {
  name: 'HandWrite',

  data () {
    return {
      lineWidth: 20,
      lineColor: 'white',
      bgColor: 'black',
      resultImg: '',
      isCrop: false,
      resultInfo: ''
    };
  },
  methods: {
    handleReset () {
      this.$refs['esign'].reset()//清空画布
      this.bgColor = 'black';
    },
    handleGenerate () {
      this.$refs['esign'].generate().then(res => {
        this.resultInfo = '';
        this.resultImg = res // 得到了签字生成的base64图片
        let str = this.base64toFile(this.resultImg,'file')//base64图片格式转文件流
        let formData = new FormData();
        formData.append("file", str);
        //发送给后端
        uploadImg(formData).then(response => {
          this.resultInfo = '识别的结果为：'+response.data;
        }).catch(response => {
          this.$message.error("识别失败")
        })
      }).catch(err => { //  没有签名，点击生成图片时调用
       this.$message.error("没有手写痕迹！！！")
        // alert(err) // 画布没有签字时会执行这里 'Not Signned'
      });
    },
    //data:base64图片格式字符串
    //filename：文件名称
    base64toFile(data, fileName) {
      const dataArr = data.split(",");
      const byteString = atob(dataArr[1]);
      const options = {
        type: "image/jpeg",
        endings: "native"
      };
      const u8Arr = new Uint8Array(byteString.length);
      for (let i = 0; i < byteString.length; i++) {
        u8Arr[i] = byteString.charCodeAt(i);
      }
      return new File([u8Arr], fileName + ".png", options);//返回文件流
    },
  }
}
</script>

<style >
.body {
  font-family: Arial;
  text-align: center;
}

canvas {
  width: 200px;
  height: 200px;
  border: 2px solid black;
  margin: 0 auto;
  display: block;
  border-radius: 10px;
  background-color: black;
}

</style>
