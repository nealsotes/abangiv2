//create side menu bar for admin page using boostrap
//links user to different pages

import React from 'react';
import UserTable from './User';
import {
    BrowserRouter as Router,
    
    Route,
    Link,
    Routes
  } from "react-router-dom";

const SideNavBar = () => {

    return (
       <Router>
         <div className="container-fluid">
            <div className="row">
                <div className="col-md-2">
                    <div className="list-group">
                        <Link to="/" className="list-group-item list-group-item-action">User</Link>
                        <Routes>
                            <Route path="/">
                                <UserTable />
                            </Route>

                        </Routes>
                    </div>
                </div>
            </div>
        </div>
       </Router>
    );
}

export default SideNavBar;