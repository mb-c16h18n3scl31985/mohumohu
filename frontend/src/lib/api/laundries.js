import client from "./client"

const headers = {
    "access-token": Cookies.get("_access_token"),
    "client": Cookies.get("_client"),
    "uid": Cookies.get("_uid")
}

/**
 * 洗濯情報一覧
 * @returns {Promise<AxiosResponse<any>>}
 */
export const getLaundryIndex = () => {
    return client.get(`/laundries`,{headers})
}

/**
 * 3日以内の洗濯物情報
 * @returns {Promise<AxiosResponse<any>>}
 */
export const getLaundryList = () => {
    return client.get(`/laundries/list`,{headers})
}

/**
 * ある1つの洗濯物情報
 * @param id
 * @returns {Promise<AxiosResponse<any>>}
 */
export const getLaundry = (id) => {
    return client.get(`/laundries/${id}`,{headers})
}

/**
 * 洗濯物データ作成
 * @param params
 * @returns {Promise<AxiosResponse<any>>}
 */
export const createLaundry = (params) => {
    return client.post("/laundries", params,{headers})
}

/**
 * 洗濯物更新
 * @param params
 * @returns {Promise<AxiosResponse<any>>}
 */
export const updateLaundry = (params) => {
    return client.put("/laundries", params,{headers})
}

/**
 * 洗濯物削除
 * @param id
 * @returns {Promise<AxiosResponse<any>>}
 */
export const deleteLaundry = (id) => {
    return client.delete(`/laundries/${id}`,{headers})
}