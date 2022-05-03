<template>
  <div>
     <h1>在线MD5|SHA加密</h1>
         <h3 class="alert alert-success" style="font-size: 20px">
      MD5
      是将任意长度的数据字符串转化成短小的固定长度的值的单向操作，任意两个字符串不应有相同的散列值。因此
      MD5 经常用于校验字符串或者文件，因为如果文件的 MD5
      不一样，说明文件内容也是不一样的。 MD5
      主要用做数据一致性验证、数字签名和安全访问认证，而不是用作加密。
      <br/>  <br/>
      SHA算法是基于MD4算法实现的，作为MD算法的继任者，成为了新一代的消息摘要算法的代表。SHA与MD算法不同之处主要在于摘要长度，SHA算法的摘要更长，安全性更高。
      SHA算法家族目前共有SHA-1、SHA-224、SHA-256、SHA-384和SHA-512五种算法，通常将后四种算法并称为SHA-2算法。
    </h3>
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
        <el-col :span="8">
          <el-form-item label="">
            <el-button
              type="primary"
              icon="el-icon-s-cooperation"
              size="medium"
              @click="encode(1)"
            >
              MD5 加密
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
              SHA224加密
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
              SHA256加密
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
              SHA1加密
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
              SHA384加密
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
              SHA512加密
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
        <!-- <el-form-item label="key键" prop="keyWord">
          <el-input v-model="formData.keyWord" placeholder="请输入key键" />
        </el-form-item> -->
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
  name: "SHA",
  components: {},
  props: [],
  data() {
    return {
      formData: {
        id: undefined,
        text: "",
        keyWord: undefined,
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
      if(this.formData.text==''){
        this.resetForm();
        return;
      }
      switch (key) {
        case 1:
          this.formData.ciphertext = CryptoJS.MD5(
            this.formData.text
          ).toString();
          break;
        case 2:
          this.formData.ciphertext = CryptoJS.SHA224(
            this.formData.text
          ).toString();
          break;
        case 3:
          this.formData.ciphertext = CryptoJS.SHA256(
            this.formData.text
          ).toString();
          break;
        case 4:
          this.formData.ciphertext = CryptoJS.SHA1(
            this.formData.text
          ).toString();
          break;
        case 5:
          this.formData.ciphertext = CryptoJS.SHA384(
            this.formData.text
          ).toString();
          break;
        case 6:
          this.formData.ciphertext = CryptoJS.SHA512(
            this.formData.text
          ).toString();
          break;
      }
    },
    resetForm() {
      this.formData.text = "";
      this.formData.ciphertext = "";
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
