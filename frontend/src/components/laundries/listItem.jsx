import React, {useEffect, useState} from "react";
import washingMachine from "../../images/laundries/washing-machine.svg"
import {laundryImage} from "../../lib/common";
import Modal from "react-modal"
import Button from "../common/button";
import {Link} from "react-router-dom";
import {getLaundry} from "../../lib/api/laundries";

const customStyles = {
    content: {
        top: '50%',
        left: '50%',
        right: 'auto',
        bottom: 'auto',
        marginRight: '-50%',
        transform: 'translate(-50%, -50%)'
    }
};

const ListItem = ({id, name, image, weekly}) => {
    const [modalIsOpen, setIsOpen] = React.useState(false);

    function openModal() {
        setIsOpen(true);
    }

    function closeModal() {
        setIsOpen(false);
    }

    const [laundry, setLaundry] = useState({});

    useEffect(() => {
        getLaundryInfo(id).then()
    }, [id]);

    const getLaundryInfo = async (id) => {
        try {
            const res = await getLaundry(id)
            console.log(res)
            setLaundry(res.data.data)
        } catch (err) {
            console.error(err)
        }
    }

    return (
        <>
            <tr className="h-16">
                <td className="h-full border-2 border-dotted border-gray-100 relative">
                    <div className="absolute inset-0 h-4/5 w-4/5 t-shirts m-auto flex items-center w-full">
                        <img src={laundryImage(image)} alt={`${name}の画像`} className="w-1/6 h-auto m-auto"/>
                        <button className="w-3/5 break-all mx-auto" onClick={openModal}>
                            {name}
                        </button>
                    </div>
                </td>

                {weekly?.map((day, index) => {
                    if (day === 2) {
                        return (<td key={index} className="border-2 border-dotted border-gray-100 bg-pink-200 w-1/12">
                            <img src={washingMachine} alt="洗濯する日" className="w-3/5 m-auto"/>
                        </td>)
                    } else if (day === 1) {
                        return (<td key={index} className="border-2 border-dotted border-gray-100 bg-pink-100"></td>)
                    } else {
                        return (<td key={index} className="border-2 border-dotted border-gray-100"></td>)
                    }
                })}
            </tr>

            <Modal isOpen={modalIsOpen}
                   onRequestClose={closeModal}
                   style={customStyles}
                   contentLabel="洗濯物詳細">
                <button onClick={closeModal} className="bg-gray-200">close</button>

                <h2 className="text-center p-1 bg-yellow-100">{laundry.name}</h2>

                <img src={laundryImage(laundry.image)} alt={`${laundry.name}の画像`}
                     className="w-1/4 h-auto mx-auto mt-4 col-span-1 bg-gray-100"/>

                <div className="w-4/5 text-sm mt-4 mx-auto">
                    <div className="flex justify-between w-full">
                        <div>
                            <h2 className="text-left">洗濯までの期間</h2>
                            <p className="bg-gray-100 p-2">{laundry.days ?? ""}</p>
                        </div>
                        <div>
                            <h2 className="text-left">次の洗濯予定日</h2>
                            <p className="bg-gray-100 p-2">{laundry.washAt}</p>
                        </div>
                    </div>

                    <div className="mt-4">
                        <h2 className="text-left">説明</h2>
                        <p className="bg-gray-100 p-2">{laundry.description ?? ""}</p>
                    </div>

                </div>

                <div className="mt-8 w-2/3 mx-auto">
                    <Link to={`/laundries/${laundry.id}`} className="bg-yellow-200 hover:bg-white p-3">変更する</Link>
                    <Button color="gray" func={() => {
                    }} value="削除する"/>
                </div>
            </Modal>
        </>
    );
}


export default ListItem