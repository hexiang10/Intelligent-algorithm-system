import request from '@/utils/request'


// 新增识图辨物
export function upload(data) {
  return request({
    url: '/face/yolo/fileUpload',
    method: 'post',
    data: data,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}

// 查询密码管理详细
export function getImg(name) {
  return request({
    url: '/face/yolo/show/',
    method: 'post',
    data:{
      fileName: name
    },
  })
}
