//
//  SignUp.swift
//  justice-for-families
//
//  Created by Cyre Jorin To on 11/21/20.
//

import Foundation
import SwiftUI

struct SignUpView: View {
    @State private var hiddenPass1 = true
    @State private var hiddenPass2 = true
    @ObservedObject var model: AuthenticationData
    var fieldWidth: CGFloat? = 350
    var fieldHeight: CGFloat? = 60
    

    var body: some View {
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

            }   .frame(width: fieldWidth, height: fieldHeight, alignment: .leading)
            
            VStack(alignment: .center, spacing:20){
                TextField("name",text: $model.name)
                    .padding()
                    .background(Constants.lightBlue)
                    .cornerRadius(20)
                    .foregroundColor(Constants.primaryFontColor)
                    .frame(width:345,height:53)
                    .font(.custom("Poppins-Regular", size: 16))

                TextField("email",text: $model.email_SignUp)
                    .padding()
                    .background(Constants.lightBlue)
                    .cornerRadius(20)
                    .foregroundColor(Constants.primaryFontColor)
                    .frame(width:345,height:53)
                    .font(.custom("Poppins-Regular", size: 16))
                    .autocapitalization(UITextAutocapitalizationType(rawValue: 0)!)

                
                HStack {
                    if self.hiddenPass1 {
                        SecureField("password", text: $model.password_SignUp).background(Constants.lightBlue).frame(width:278).foregroundColor(Constants.primaryFontColor).font(.custom("Poppins-Regular", size: 16)).autocapitalization(UITextAutocapitalizationType(rawValue: 0)!)
                    } else {
                        TextField("password", text: $model.password_SignUp).background(Constants.lightBlue).frame(width:278).foregroundColor(Constants.primaryFontColor).font(.custom("Poppins-Regular", size: 16)).autocapitalization(UITextAutocapitalizationType(rawValue: 0)!)
                    }
                    
                    Button(action: {self.hiddenPass1.toggle()}) {
                        Image(systemName: !self.hiddenPass1 ? "eye.fill": "eye.slash.fill")
                            .foregroundColor((!self.hiddenPass1) ? Color.green : Color.secondary)
                    }
                    
                }   .padding()
                    .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.white,lineWidth:1)).background(RoundedRectangle(cornerRadius: 20).fill(Constants.lightBlue))
                
                HStack {
                    if self.hiddenPass2 {
                        SecureField("confirm password", text: $model.reEnterPassword).background(Constants.lightBlue).frame(width:278).foregroundColor(Constants.primaryFontColor).font(.custom("Poppins-Regular", size: 16)).autocapitalization(UITextAutocapitalizationType(rawValue: 0)!)
                    } else {
                        TextField("confirm password", text: $model.reEnterPassword).background(Constants.lightBlue).frame(width:278).foregroundColor(Constants.primaryFontColor).font(.custom("Poppins-Regular", size: 16)).autocapitalization(UITextAutocapitalizationType(rawValue: 0)!)
                    }
                    
                    Button(action: {self.hiddenPass2.toggle()}) {
                        Image(systemName: !self.hiddenPass2 ? "eye.fill": "eye.slash.fill")
                            .foregroundColor((!self.hiddenPass2) ? Color.green : Color.secondary)
                    }
                    
                }   .padding()
                .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.white,lineWidth:1)).background(RoundedRectangle(cornerRadius: 20).fill(Constants.lightBlue))
            }.padding(.bottom,55)

            
            
            Button(action: {
                model.signup()
            }) {
                Text("Sign Up")
                    .foregroundColor(Color.white)
                    .fontWeight(.heavy)
                    .padding()
                    .frame(width: fieldWidth, height: fieldHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Capsule().fill(Constants.grey))
                    
            }.padding([.leading, .trailing],30)
            
            HStack {
                Text("I have an account. ")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Constants.primaryFontColor)

                
                HStack {
                    Button(action: {model.isSignUp.toggle()}) {
                        Text("Login")
                            .foregroundColor(Constants.tertiaryFontColor)
                            .font(.system(size: 16, weight: .heavy))
                    }
                    
                }
            }
           
            Spacer()
        }.background(Color.white)
    }
}

