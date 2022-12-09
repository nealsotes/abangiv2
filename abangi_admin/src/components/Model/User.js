//create User model class



class User {
    constructor(userid, fullName, email, contact, address,userImage,userGovertId,role,isAbangiVerified,status,isMailConfirmed,) {
        this.userid = userid;
        this.fullName = fullName;
        this.email = email;
        this.contact = contact;
        this.address = address;
        this.userImage = userImage;
        this.userGovertId = userGovertId;
        this.role = role;
        this.isAbangiVerified = isAbangiVerified;
        this.status = status;
        this.isMailConfirmed = isMailConfirmed;
    }
}

export default User;


