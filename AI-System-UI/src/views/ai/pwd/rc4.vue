<template>
  <div>
    <div>
      <h1>在线RC4加密/解密</h1>
      <h2 class="alert alert-success" style="font-size: 20px">
      RC4于1987年提出，和DES算法一样，是一种对称加密算法，也就是说使用的密钥为单钥（或称为私钥）。但不同于DES的是，RC4不是对明文进行分组处理，而是字节流的方式依次加密明文中的每一个字节，解密的时候也是依次对密文中的每一个字节进行解密。

       RC4算法的特点是算法简单，运行速度快，而且密钥长度是可变的，可变范围为1-256字节(8-2048比特)，在如今技术支持的前提下，当密钥长度为128比特时，用暴力法搜索密钥已经不太可行，所以可以预见RC4的密钥范围任然可以在今后相当长的时间里抵御暴力搜索密钥的攻击。实际上，如今也没有找到对于128bit密钥长度的RC4加密算法的有效攻击方法。
      </h2>
    </div>
    <el-row :gutter="15">
      <el-form
        ref="elForm"
        :model="formData"
        :rules="rules"
        size="medium"
        label-width="100px"
      >
        <el-col :span="24">
          <el-form-item label="原文" prop="text">
            <el-input
              v-model="formData.text"
              type="textarea"
              placeholder="请输入原文"
              :autosize="{ minRows: 4, maxRows: 4 }"
              :style="{ width: '100%' }"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="密匙" prop="keyWord">
            <el-input
              v-model="formData.keyWord"
              placeholder="可选"
              clearable
              :style="{ width: '100%' }"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="">
            <el-button
              type="warning"
              icon="el-icon-bottom"
              size="medium"
              round
              @click="encode()"
            >
              加密
            </el-button>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="">
            <el-button
              type="danger"
              icon="el-icon-top"
              size="medium"
              round
              @click="decode()"
            >
              解密
            </el-button>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="">
            <el-button
              type="info"
              icon="el-icon-refresh-right"
              size="medium"
              round
              @click="resetForm"
            >
              重置
            </el-button>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="">
            <el-button
              type="primary"
              icon="el-icon-refresh-right"
              size="medium"
              round
              @click="handleAdd"
            >
              保存
            </el-button>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="密文" prop="output">
            <el-input
              v-model="formData.ciphertext"
              type="textarea"
              :autosize="{ minRows: 4, maxRows: 4 }"
              :style="{ width: '100%' }"
              placeholder="请输入密文"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-form>
    </el-row>

    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="formData" :rules="rules" label-width="80px">
        <el-form-item label="原文" prop="text">
          <el-input
            v-model="formData.text"
            type="textarea"
            readonly=""
            :disabled="true"
            placeholder="请返回填写原文"
          />
        </el-form-item>
        <el-form-item label="key键" prop="keyWord">
          <el-input
            v-model="formData.keyWord"
            placeholder="可选"
            :disabled="true"
          />
        </el-form-item>
        <el-form-item label="密文" prop="ciphertext">
          <el-input
            v-model="formData.ciphertext"
            type="textarea"
            readonly=""
            :disabled="true"
            placeholder="请返回生成密文"
          />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input
            v-model="formData.remark"
            type="textarea"
            placeholder="请输入备注"
          />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button :loading="buttonLoading" type="primary" @click="submitForm"
          >确 定</el-button
        >
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import CryptoJS from "crypto-js";
import { listPwd, getPwd, delPwd, addPwd, updatePwd } from "@/api/ai/pwd";

export default {
  name: "RC4",
  components: {},
  props: [],
  data() {
    return {
      formData: {
        id: undefined,
        text: "",
        keyWord: "",
        ciphertext: "",
        remark: undefined,
        encodeType: 'RC4',
        delFlag: undefined,
        createTime: undefined,
        createBy: undefined,
        updateTime: undefined,
        updateBy: undefined,
        userId: undefined,
      },
      title: "",
      open: false,
      buttonLoading: false,
      rules: {
        text: [
          {
            required: false,
            message: "请输入原文",
            trigger: "blur",
          },
        ],
        keyWord: [
          {
            required: false,
            message: "请输入密匙",
            trigger: "blur",
          },
        ],
        ciphertext: [{}],
      },
    };
  },
  computed: {},
  watch: {},
  created() {},
  mounted() {},
  methods: {
    encode() {
      if (this.formData.text === "") {
        this.resetForm();
        return;
      }
      this.formData.ciphertext = CryptoJS.RC4.encrypt(
        this.formData.text,
        this.formData.keyWord
      ).toString();
      if (this.formData.ciphertext == "") {
        this.$message.error("加密失败");
      } else this.$modal.msgSuccess("加密成功");
    },
    decode() {
      if (this.formData.ciphertext === "") {
        this.resetForm();
        return;
      }
       this.formData.text='';
       try{
        this.formData.text = CryptoJS.RC4.decrypt(
          this.formData.ciphertext,
          this.formData.keyWord
        ).toString(CryptoJS.enc.Utf8);
        if (this.formData.text == "") {
          this.$message.error("解密失败");
        } else this.$modal.msgSuccess("解密成功");
       }
       catch{
        this.$message.error("解密失败");
       }
    },
    handleAdd() {
      this.open = true;
      this.title = "保存密码";
    },
    submitForm() {
      this.buttonLoading = true;
      if (this.text == "") {
        this.$message.error("请输入原文");
        this.buttonLoading = false;
        return;
      }
      if (this.ciphertext == "") {
        this.$message.error("请输入密文");
        this.buttonLoading = false;
        return;
      }
      addPwd(this.formData)
        .then((response) => {
          this.$modal.msgSuccess("保存成功，可前往密码管理中心查看");
          this.open = false;
        })
        .finally(() => {
          this.buttonLoading = false;
        });
    },
    resetForm() {
      this.formData.text = "";
      this.formData.ciphertext = "";
      this.formData.keyWord = "";
    },
    cancel() {
      this.open = false;
    },
  },
};
</script>
<style>
h1 {
  text-align: center;
  font-size: 30px;
}
.alert-success {
  color: #3c763d;
  background-color: #dff0d8;
  border-color: #d6e9c6;
}
.alert {
  padding: 15px;
  margin-bottom: 20px;
  border: 1px solid transparent;
  border-radius: 4px;
  line-height: 40px;
  margin: 20px;
}
</style>

