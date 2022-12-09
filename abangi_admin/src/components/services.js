import React from "react";
import axios from "axios";
import { environment } from "../environment";


//generate a service to call the API using axios and with this environment variable

export const apicall = axios.create({
    baseURL: environment.API_URL
});

//export the service to be used in the components
export const API = {
    get: (url) => apicall.get(url),
    post: (url, data) => apicall.post(url, data),
    put: (url, data) => apicall.put(url, data),
    delete: (url) => apicall.delete(url)
};


