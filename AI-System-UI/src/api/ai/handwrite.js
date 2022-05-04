import request from '@/utils/request'

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
