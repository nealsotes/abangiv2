//create User table using react boostrap
import React from 'react';
import { Table } from 'react-bootstrap';

import { useState, useEffect } from 'react';
import {API} from '../services';

const UserTable = () => {
    const [users, setUsers] = useState([]);

    useEffect(() => {
        API.get('users')
            .then(res => {
                setUsers(res.data);
            })
            .catch(err => {
                console.log(err);
            })
    }, []);


    return (
        <div>
            <Table striped bordered hover>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Contact</th>
                        <th>Address</th>
                        <th>User Image</th>
                        <th>User Govert ID</th>
                        <th>Role</th>
                        <th>Is Abangi Verified</th>
                        <th>Status</th>
                        <th>Is Mail Confirmed</th>
                    </tr>
                </thead>
                <tbody>
                    {users.map((user) => (
                        <tr key={user.userid}>
                            <td>{user.userid}</td>
                            <td>{user.fullName}</td>
                            <td>{user.email}</td>
                            <td>{user.contact}</td>
                            <td>{user.address}</td>
                            <td>{user.userImage}</td>
                            <td>{user.userGovertId}</td>
                            <td>{user.role}</td>
                            <td>{user.isAbangiVerified}</td>
                            <td>{user.status}</td>
                            <td>{user.isMailConfirmed}</td>
                        </tr>
                    ))}
                </tbody>
            </Table>
        </div>
    );
}

export default UserTable;