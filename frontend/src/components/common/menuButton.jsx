import React from "react";
import menu from "../../images/common/menu.svg";
import {Link} from "react-router-dom";

const MenuButton = ({handleMouseDown}) => {
    return (
        <Link className="h-16 bg-gray-400 flex justify-items-center items-center hover:bg-blue-200" to="/laundries" onMouseDown={handleMouseDown}>
            <img src={menu} alt="メニュー" className="h-2/5 w-auto mx-auto"/>
        </Link>
    );

}

export default MenuButton