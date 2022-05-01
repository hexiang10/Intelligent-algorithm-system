<template>
  <div class="body">

    <h1>Face Recognition</h1>
    <canvas id="imageCanvas"></canvas>
    <input type="file" id="imageLoader" @change="handleImage" />
    <button @click="analyzeImage">Analyze Image</button>
  </div>
</template>


<script>

import { getTestObj } from '@/api/ai/obj'

export default {
  name: "Obj",
  methods:{
    analyzeImage(){
      getTestObj().then(result => {
        this.$modal.msgSuccess(result.data);
      })
    },
    handleImage(e) {
      var canvas = document.getElementById("imageCanvas");
      var ctx = canvas.getContext("2d");
      var reader = new FileReader();
      reader.onload = function (event) {
        var img = new Image();
        img.onload = function () {
          canvas.width = img.width;
          canvas.height = img.height;
          ctx.drawImage(img, 0, 0);
        };
        img.src = event.target.result;
      };
      reader.readAsDataURL(e.target.files[0]);
      setTimeout(function () {
        console.log(canvas.toDataURL());
      }, 1000);

    }
  }
}
</script>

<style>
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

input,
button {
  display: block;
  margin: 0 auto;
  margin-top: 20px;
  color: black;
  padding: 10px;
  border: 0;
  outline: none;
  background: rgb(119, 119, 119);
  border-radius: 10px;
}

button {
  color: black;
  background: rgb(11, 253, 104);
}

</style>
