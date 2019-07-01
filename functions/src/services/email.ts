import * as nodemailer from 'nodemailer';
export class Email {
    private emailAdmin: string = 'anhh4533@gmail.com';
    private passwordAdmin: string = 'hoanganH123@';
    private emailTo: string;
    private displayNameTo: string;
    private transporter: any;
    constructor(email: string, displayName: string) {
        this.emailTo = email;
        this.displayNameTo = displayName;
        this.initEmailSystem(this.emailAdmin, this.passwordAdmin);
    }

    private initEmailSystem(emailAdmin: string, passwordAdmin: string) {
        this.transporter = nodemailer.createTransport({
            host: 'smtp.gmail.com',
            port: 465,
            secure: true,
            auth: {
                user: emailAdmin,
                pass: passwordAdmin
            }
        });
    }

    private createMailOptions(emailAdmin: string, emailTo: string, displayNameTo: string) {
        const mailOptions = {
            from: emailAdmin,
            to: emailTo,
            subject: 'Welcome to Guess The Flag Game',
            text: `Xin chào ${displayNameTo}, chúng tôi rất vinh hạnh khi được bạn sử dụng ứng dụng của chúng tôi. Mong bạn có thời gian vui vẻ khi sử dụng ứng dụng. Chân thành cám ơn`
        };
        return mailOptions;
    }

    public sendEmail() {
        const mailOptions = this.createMailOptions(this.emailAdmin, this.emailTo, this.displayNameTo);
        return this.transporter.sendMail(mailOptions, function (error, info) {
            if (error) {
                console.log(error);
            } else {
                console.log('Email sent: ' + info.response);
            }
        });
    }
}