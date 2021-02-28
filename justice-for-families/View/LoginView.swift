//
//  LoginView.swift
//  justice-for-families
//
//  Created by Joshua Chan on 11/15/20.
//

import Foundation
import SwiftUI



struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var hiddenPass = true
    
    private var fieldWidth: CGFloat? = 350
    private var fieldHeight: CGFloat? = 60
    var body: some View {
        NavigationView {
            ScrollView{
            VStack (alignment: .center, spacing: 20) {
                Spacer()
                Spacer()
                Image("J4F-Logo")
                    .resizable()
                    .scaledToFill() // <=== Saves aspect ratio
                    .frame(width: 270.0, height:62)
                    .padding(.top,35)
                

                VStack(alignment: .leading, spacing: -30) {
                    Text("Welcome,")
                        .padding()
                        .font(.custom("Poppins-Medium", size: 24))
                        .foregroundColor(Constants.primaryFontColor)
                    Text("Sign in to continue!")
                        .padding()
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Constants.secondaryFontColor)
                }   .frame(width: fieldWidth, height: fieldHeight, alignment: .leading)
                    .padding(.bottom,25)

                
                VStack(alignment: .center){
                    HStack{
                        TextField("email",text: self.$email)
                            .foregroundColor(Constants.primaryFontColor)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.bottom,26)
                            .frame(width:345,height:53)
                            .font(.custom("Poppins-Regular", size: 16))
                    }
                    
                    HStack {
                        if self.hiddenPass {
                            SecureField("password", text: self.$password).background(Color.white).frame(width:278).foregroundColor(Constants.primaryFontColor).font(.custom("Poppins-Regular", size: 16))
                        } else {
                            TextField("password", text: self.$password).background(Color.white).frame(width:278).foregroundColor(Constants.primaryFontColor).font(.custom("Poppins-Regular", size: 16))
                        }
                        
                        Button(action: {self.hiddenPass.toggle()}) {
                            Image(systemName: !self.hiddenPass ? "eye.fill": "eye.slash.fill")
                                .foregroundColor((!self.hiddenPass) ? Color.green : Color.secondary)
                        }
                        
                    }   .padding()
                        .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.white,lineWidth:1)).background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                    
                    
                    
                    Button(action: {}, label: {
                        Text("Forgot password?")
                            .font(.custom("Poppins-Regular", size: 13))
                            .foregroundColor(Constants.primaryFontColor)
                    })
                    .frame(width: fieldWidth, height: CGFloat(fieldHeight!/2), alignment: .trailing)
                }
                .padding(.bottom,30)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Login")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color.white)
                        .fontWeight(.heavy)
                        .padding()
                        .frame(width: fieldWidth, height: fieldHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Capsule().fill(Constants.grey))
                        
                }.padding([.leading, .trailing],30)
                
                
                HStack(alignment: .center, spacing: 0){
                    Text("I'm a new user. ")
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(Constants.primaryFontColor)
                    NavigationLink(destination: SignUpView()){
                        Text("Sign Up")
                            .foregroundColor(Constants.tertiaryFontColor)
                            .font(.custom("Poppins-Medium", size: 16))
                    }
                }
                Spacer()
            }
            
        }.navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Constants.loginBackground).ignoresSafeArea()
        }.navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
        }
    }
}
