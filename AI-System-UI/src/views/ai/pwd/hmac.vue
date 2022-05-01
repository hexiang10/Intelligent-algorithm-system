<template>
  <div>
    <h1>在线HMAC加密</h1>
    <h2 class="alert alert-success" style="font-size: 20px">
      MAC算法结合了MD和SHA算法的优势，并加入秘钥的支持，是一种更为安全的消息摘要算法。因为MAC算法融合了秘钥散列函数（keyed-Hash），通常我们也把MAC称为HMAC（keyed-Hash
      Message Authentication Code）。
      MAC算法主要集合了MD和SHA两大系列消息摘要算法。MD系列算法有HmacMD2、HmacMD4和HmacMD5三种算法；SHA系列算法有HmacSHA1、HmacSHA224、HmacSHA256、HmacSHA384和HmacSHA512五种算法。
    </h2>
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
        <el-col :span="8">
          <el-form-item label="">
            <el-button
              type="primary"
              icon="el-icon-s-cooperation"
              size="medium"
              @click="encode(1)"
            >
              HmacMD5 加密
            </el-button>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="">
            <el-button
              type="primary"
              icon="el-icon-s-cooperation"
              size="medium"
              @click="encode(2)"
            >
               HmacSHA224加密
            </el-button>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="">
            <el-button
              type="primary"
              icon="el-icon-s-cooperation"
              size="medium"
              @click="encode(3)"
            >
               HmacSHA256加密
            </el-button>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="">
            <el-button
              type="primary"
              icon="el-icon-s-cooperation"
              size="medium"
              @click="encode(4)"
            >
               HmacSHA1加密
            </el-button>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="">
            <el-button
              type="primary"
              icon="el-icon-s-cooperation"
              size="medium"
              @click="encode(5)"
            >
               HmacSHA384加密
            </el-button>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="">
            <el-button
              type="primary"
              icon="el-icon-s-cooperation"
              size="medium"
              @click="encode(6)"
            >
               HmacSHA512加密
            </el-button>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="密文" prop="ciphertext">
            <el-input
              v-model="formData.ciphertext"
              type="textarea"
              :autosize="{ minRows: 4, maxRows: 4 }"
              :style="{ width: '100%' }"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="">
            <el-button
              type="success"
              icon="el-icon-folder-add"
              size="medium"
              @click="handleAdd"
            >
              保存密码
            </el-button>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="">
            <el-button
              type="info"
              icon="el-icon-refresh-right"
              size="medium"
              @click="resetForm()"
            >
              重置文本内容
            </el-button>
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
  components: {},
  props: [],
  data() {
    return {
      formData: {
        id: undefined,
        text: "",
        keyWord: '',
        ciphertext: undefined,
        remark: undefined,
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
        text: [],
        ciphertext: [],
      },
    };
  },
  computed: {},
  watch: {},
  created() {},
  mounted() {},
  methods: {
    encode(key) {
      if (this.formData.text == "") {
        this.resetForm();
        return;
      }
      switch (key) {
        case 1:
          this.formData.ciphertext = CryptoJS.HmacMD5(
            this.formData.text,
            this.formData.keyWord
          ).toString();
          break;
        case 2:
          this.formData.ciphertext = CryptoJS.HmacSHA224(
            this.formData.text,
            this.formData.keyWord
          ).toString();
          break;
        case 3:
          this.formData.ciphertext = CryptoJS.HmacSHA256(
            this.formData.text,
            this.formData.keyWord
          ).toString();
          break;
        case 4:
          this.formData.ciphertext = CryptoJS.HmacSHA1(
            this.formData.text,
            this.formData.keyWord
          ).toString();
          break;
        case 5:
          this.formData.ciphertext = CryptoJS.HmacSHA384(
            this.formData.text,
            this.formData.keyWord
          ).toString();
          break;
        case 6:
          this.formData.ciphertext = CryptoJS.HmacSHA512(
            this.formData.text,
            this.formData.keyWord
          ).toString();
          break;
      }
      if (this.formData.ciphertext == "") {
        this.$message.error("加密失败");
      }else {
        this.$message.success("加密成功");
      }
    },
    resetForm() {
      this.formData.text = "";
      this.formData.ciphertext = "";
      this.formData.keyWord = "";
    },
    cancel() {
      this.open = false;
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
  line-height: 30px;
  margin: 20px;
}
</style>
