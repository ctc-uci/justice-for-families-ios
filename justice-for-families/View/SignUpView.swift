//
//  SignUp.swift
//  justice-for-families
//
//  Created by Cyre Jorin To on 11/21/20.
//

import Foundation
import SwiftUI

struct SignUpView: View {
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    private var fieldWidth: CGFloat? = 350
    private var fieldHeight: CGFloat? = 60
    
    @State private var homeFeedViewIsPresented = false
    @State private var loginViewIsPresented = false

    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Create an account,")
                .foregroundColor(Color(.sRGB, red: 16/255.0, green: 83/255.0, blue: 110/255.0, opacity: 1.0))
                .font(Font.custom("AvenirNext-SemiBold", size: 24))
            Text("Sign up to get started!")
                .font(Font.custom("AvenirNext-Regular", size: 18))
                .padding(.bottom, 32)
            TextField("name", text: $name)
                .padding()
                .frame(width: self.fieldWidth, height: self.fieldHeight, alignment: .leading)
                .background(Color(.sRGB, red: 196/255.0, green: 215/255.0, blue: 235/255.0, opacity: 0.50))
                .cornerRadius(20)
                .font(Font.custom("AvenirNext-Regular", size: 16))
                .foregroundColor(Color(.sRGB, red: 25/255.0, green: 118/255.0, blue: 157/255.0, opacity: 1.0))
                .padding(.bottom, 20)
            
            TextField("email", text: $email)
                .padding()
                .frame(width: self.fieldWidth, height: self.fieldHeight, alignment: .leading)
                .background(Color(.sRGB, red: 196/255.0, green: 215/255.0, blue: 235/255.0, opacity: 0.50))
                .cornerRadius(20)
                .font(Font.custom("AvenirNext-Regular", size: 16))
                .foregroundColor(Color(.sRGB, red: 25/255.0, green: 118/255.0, blue: 157/255.0, opacity: 1.0))
                .padding(.bottom, 20)
            
            TextField("password", text: $password)
                .padding()
                .frame(width: self.fieldWidth, height: self.fieldHeight, alignment: .leading)
                .background(Color(.sRGB, red: 196/255.0, green: 215/255.0, blue: 235/255.0, opacity: 0.50))
                .cornerRadius(20)
                .font(Font.custom("AvenirNext-Regular", size: 16))
                .foregroundColor(Color(.sRGB, red: 25/255.0, green: 118/255.0, blue: 157/255.0, opacity: 1.0))
                .padding(.bottom, 20)
            
            VStack (alignment: .center, spacing: 20) {
                Image("testLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                
                VStack(alignment: .leading, spacing: -30) {
                    Text("Sign Up for an Account")
                        .padding()
                        .font(.system(size: 20, weight: .heavy))
                }.frame(width: fieldWidth, height: fieldHeight, alignment: .center)
                
                
                VStack(alignment: .leading, spacing: 25){
                    TextField("Name",text: self.$name)
                        .padding()
                        .background(Capsule().fill(Color.white))
                        .frame(width: fieldWidth, height: fieldHeight, alignment: .center)
                    TextField("Email",text: self.$email)
                        .padding()
                        .background(Capsule().fill(Color.white))
                        .frame(width: fieldWidth, height: fieldHeight, alignment: .center)
                    TextField("Password", text: self.$password)
                        .padding()
                        .frame(width: fieldWidth, height: fieldHeight, alignment: .center)
                        .background(Capsule().fill(Color.white))
                    TextField("Confirm Password", text: self.$confirmPassword)
                        .padding()
                        .frame(width: fieldWidth, height: fieldHeight, alignment: .center)
                        .background(Capsule().fill(Color.white))
                    
                }.padding([.leading, .trailing], 27.5)
                
                
                VStack {
                    Text("*At least 8 characters")
                    Text("*At least 1 upper case")
                    Text("*At least 1 lower case")
                    Text("*At least 1 special character")
                    Text("*At least 1 number")
                }
                
                Button(action: {
                    let passwordRequirement = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{8,}$")
                    if self.name.count > 0 && self.email.count > 0 && self.password == self.confirmPassword && passwordRequirement.evaluate(with: password) {
                        print("Valid inputs")
                    }
                    else {
                        print("Invalid inputs")
                    }
                }) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: fieldWidth, height: fieldHeight, alignment: .center)
                        .background(Capsule().fill(Color.gray))
                        .cornerRadius(15.0)
                }
                HStack {
                    Text("Already a Member?")
                        .font(.system(size: 15))
                    HStack {
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.black)
                        }
                    }
                }
                Spacer()
                
                Spacer()
            }.background(Constants.backgroundColor)
            .navigationBarHidden(true)
        }.navigationBarHidden(true)
            TextField("confirm password", text: $confirmPassword)
                .padding()
                .frame(width: self.fieldWidth, height: self.fieldHeight, alignment: .leading)
                .background(Color(.sRGB, red: 196/255.0, green: 215/255.0, blue: 235/255.0, opacity: 0.50))
                .cornerRadius(20)
                .font(Font.custom("AvenirNext-Regular", size: 16))
                .foregroundColor(Color(.sRGB, red: 25/255.0, green: 118/255.0, blue: 157/255.0, opacity: 1.0))
                .padding(.bottom, 80)
            
            Button(action: {
                self.homeFeedViewIsPresented.toggle()
            }, label: {
                Text("Sign Up")
                    .foregroundColor(Color.white)
            })
            .frame(width: 350, height: 53, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color(.sRGB, red: 25/255.0, green: 118/255.0, blue: 187/255.0, opacity: 1.0))
            .cornerRadius(20)
            .fullScreenCover(isPresented: $homeFeedViewIsPresented, content: {
                HomeFeed()
            })
            .padding(.bottom, 13)
            
            Button(action: {
                self.loginViewIsPresented.toggle()
            }, label: {
                Text("I have an account. Login")
                    .foregroundColor(Color(.sRGB, red: 25/255.0, green: 118/255.0, blue: 187/255.0, opacity: 1.0))
            })
            .frame(width: 350, height: 53, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .fullScreenCover(isPresented: $loginViewIsPresented, content: {
                LoginView()
            })
        }
    }

}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView()
        }
    }
}
