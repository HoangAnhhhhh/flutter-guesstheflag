import * as nodemailer from 'nodemailer';
export class Email {
    private emailAdmin: string = 'anhh4533@gmail.com';
    private passwordAdmin: string = 'hoanganH123@';
    private emailTo: string;
    private displayNameTo: string;

    constructor(email: string, displayName: string) {
        this.emailTo = email;
        this.displayNameTo = displayName;
    }
    public sendEmail(): void {
        const transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: this.emailAdmin,
                pass: this.passwordAdmin
            }
        });

        const mailOptions = {
            from: this.emailAdmin,
            to: this.emailTo,
            subject: 'Gửi email dùng Node.js --- dammio.com',
            text: `Xin chào ${this.displayNameTo}, đây là email gửi bằng Node.js --- dammio.com`
        };

        transporter.sendMail(mailOptions, function (error, info) {
            if (error) {
                console.log(error);
            } else {
                console.log('Email sent: ' + info.response);
            }
        });
    }
}