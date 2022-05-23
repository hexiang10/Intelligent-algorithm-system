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


export function getImg(location,name) {
  return request({
    url: '/img/handler/'+location,
    method: 'post',
    data:{
      fileName: name
    },
  })
}


export function getObjImg(name) {
  return request({
    url: '/face/show/',
    method: 'post',
    data:{
      fileName: name
    },
  })
}


export function uploadImg(data) {
  return request({
    url: '/handwrite/fileUpload',
    method: 'post',
    data: data,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}

export function getCarImg(name) {
  return request({
    url: '/car/detect/',
    method: 'post',
    data:{
      fileName: name
    },
  })
}

export function getIdCardImg(name) {
  return request({
    url: '/idcard/detect/',
    method: 'post',
    data:{
      fileName: name
    },
  })
}
