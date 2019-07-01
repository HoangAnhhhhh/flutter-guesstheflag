import * as nodemailer from 'nodemailer';
export class Email {
    private emailAdmin: string = 'anhh4533@gmail.com';
    private passwordAdmin: string = 'hoanganH123@';
    private emailTo: string;
    private displayNameTo: string;

    constructor(email: string, displayName: string) {
        this.emailTo = email;
        this.displayNameTo = displayName;
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
            subject: 'Welcome to Guess The Flag Game',
            text: `Xin chào ${this.displayNameTo}, chúng tôi rất vinh hạnh khi được bạn sử dụng ứng dụng của chúng tôi. Mong bạn có thời gian vui vẻ khi sử dụng ứng dụng. Chân thành cám ơn`
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