<template>
  <div class="app-container home">
    <vue-markdown>{{contents}}</vue-markdown>
  </div>
</template>

<script>

import VueMarkdown from 'vue-markdown'
import markDownFile from './md/index.md'

export default {
  name: "Index",
  data() {
    return {
      // 版本号
      version: "3.5.0",
      contents: markDownFile
    };
  },
  components: {
    VueMarkdown
  },
  methods: {
    goTarget(href) {
      window.open(href, "_blank");
    },
  },
};
</script>

<style>
 .a{
   color: #00afff;
 }
</style>

