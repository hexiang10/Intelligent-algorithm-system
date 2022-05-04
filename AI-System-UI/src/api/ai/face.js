import request from '@/utils/request'


export function upload(data) {
  return request({
    url: '/image/fileUpload',
    method: 'post',
    data: data,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}


export function getImg(name) {
  return request({
    url: '/face/show/',
    method: 'post',
    data:{
      fileName: name
    },
  })
}
