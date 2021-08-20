// import React, {useState} from "react";
import Header from "../../components/common/header";
import Footer from "../../components/common/footer";
import Weather from "../../components/users/weather";
import LaundryList from "../../components/users/laundryList";
import dayjs from "dayjs";

const UsersIndex = () => {
    const date = dayjs().format('MM/DD ddd')
    return (
        <>
            <Header date={date}/>
            <h1 className="text-green-600">h1tag</h1>
            <Weather/>
            <LaundryList/>
            <Footer/>
        </>
    );
}


export default UsersIndex