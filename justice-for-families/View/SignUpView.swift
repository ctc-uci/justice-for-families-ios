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
    @State private var password1 = ""
    @State private var confirmPassword1 = ""
    @State private var hiddenPass1 = true
    @State private var password2 = ""
    @State private var confirmPassword2 = ""
    @State private var hiddenPass2 = true
    
    private var fieldWidth: CGFloat? = 350
    private var fieldHeight: CGFloat? = 60
    

    var body: some View {
        
        NavigationView {
            ScrollView{
            VStack (alignment: .center, spacing: 20) {
                Image("J4F-Logo")
                    .resizable()
                    .scaledToFill() // <=== Saves aspect ratio
                    .frame(width: 270.0, height:62)
                    .padding(.top,35)
                
                VStack(alignment: .leading, spacing: -30) {
                    Text("Create an Account,")
                        .padding()
                        .font(.custom("Poppins-Medium", size: 24))
                        .foregroundColor(Constants.primaryFontColor)
                    Text("Sign up to get started!")
                        .padding()
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Constants.secondaryFontColor)
                }   .frame(width: fieldWidth, height: fieldHeight, alignment: .leading).padding(.bottom,25)
                
                VStack(alignment: .center, spacing:20){
                    TextField("name",text: self.$name)
                        .padding()
                        .background(Constants.lightBlue)
                        .cornerRadius(20)
                        .foregroundColor(Constants.primaryFontColor)
                        .frame(width:345,height:53)
                        .font(.custom("Poppins-Regular", size: 16))
                    TextField("email",text: self.$email)
                        .padding()
                        .background(Constants.lightBlue)
                        .cornerRadius(20)
                        .foregroundColor(Constants.primaryFontColor)
                        .frame(width:345,height:53)
                        .font(.custom("Poppins-Regular", size: 16))
                    
                    HStack {
                        if self.hiddenPass1 {
                            SecureField("password", text: self.$password1).background(Constants.lightBlue).frame(width:278).foregroundColor(Constants.primaryFontColor).font(.custom("Poppins-Regular", size: 16))
                        } else {
                            TextField("password", text: self.$password1).background(Constants.lightBlue).frame(width:278).foregroundColor(Constants.primaryFontColor).font(.custom("Poppins-Regular", size: 16))
                        }
                        
                        Button(action: {self.hiddenPass1.toggle()}) {
                            Image(systemName: !self.hiddenPass1 ? "eye.fill": "eye.slash.fill")
                                .foregroundColor((!self.hiddenPass1) ? Color.green : Color.secondary)
                        }
                        
                    }   .padding()
                        .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.white,lineWidth:1)).background(RoundedRectangle(cornerRadius: 20).fill(Constants.lightBlue))
                    
                    HStack {
                        if self.hiddenPass2 {
                            SecureField("confirm password", text: self.$password2).background(Constants.lightBlue).frame(width:278).foregroundColor(Constants.primaryFontColor).font(.custom("Poppins-Regular", size: 16))
                        } else {
                            TextField("confirm password", text: self.$password2).background(Constants.lightBlue).frame(width:278).foregroundColor(Constants.primaryFontColor).font(.custom("Poppins-Regular", size: 16))
                        }
                        
                        Button(action: {self.hiddenPass2.toggle()}) {
                            Image(systemName: !self.hiddenPass2 ? "eye.fill": "eye.slash.fill")
                                .foregroundColor((!self.hiddenPass2) ? Color.green : Color.secondary)
                        }
                        
                    }   .padding()
                        .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.white,lineWidth:1)).background(RoundedRectangle(cornerRadius: 20).fill(Constants.lightBlue))
                }.padding(.bottom,55)
                
//
//                VStack {
//                    Text("*At least 8 characters")
//                    Text("*At least 1 upper case")
//                    Text("*At least 1 lower case")
//                    Text("*At least 1 special character")
//                    Text("*At least 1 number")
//                }
                
                Button(action: {
                    let passwordRequirement = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{8,}$")
                    if self.name.count > 0 && self.email.count > 0 && self.password1 == self.confirmPassword1 && passwordRequirement.evaluate(with: password1) {
                        print("Valid inputs")
                    }
                    else {
                        print("Invalid inputs")
                    }
                }) {
                    Text("Sign Up")
                        .foregroundColor(Color.white)
                        .fontWeight(.heavy)
                        .padding()
                        .frame(width: fieldWidth, height: fieldHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Capsule().fill(Constants.grey))
                        
                }.padding([.leading, .trailing],30)
                HStack(alignment: .center, spacing: 0) {
                    Text("I have an account. ")
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(Constants.primaryFontColor)
                    HStack {
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .foregroundColor(Constants.tertiaryFontColor)
                                .font(.custom("Poppins-Medium", size: 16))
                        }
                    }
                }
                
                Spacer()
            }.background(Color.white)
           
        }.navigationBarHidden(true)
    }.navigationBarHidden(true)
    }

}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView()
        }
    }
}
