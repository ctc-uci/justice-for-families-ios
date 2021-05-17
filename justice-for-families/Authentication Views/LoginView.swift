
//
//  LoginView.swift
//  justice-for-families
//
//  Created by Joshua Chan on 11/15/20.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

struct LoginView: View {
    @State private var hiddenPass = true
    
    @ObservedObject var model: AuthenticationData
    private var fieldWidth: CGFloat? = 350
    private var fieldHeight: CGFloat? = 60
    
    @State private var email: String = ""
    @State private var pass: String = ""
    
    public init(model: AuthenticationData) {
        self._model = ObservedObject(wrappedValue: model)
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .center, spacing: 20) {
                //Spacer()
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
                .cornerRadius(20)
                .padding(.bottom, 26)
                .padding(.bottom,25)
                
                
                VStack(alignment: .center){
                    HStack{
                        TextField("email",text: $email)
                            .foregroundColor(Constants.primaryFontColor)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.bottom,26)
                            .frame(width:345,height:53)
                            .autocapitalization(UITextAutocapitalizationType(rawValue: 0)!)
                    }
                    
                    HStack {
                        if self.hiddenPass {
                            SecureField("password", text: $pass).background(Color.white).frame(width:278).foregroundColor(Constants.primaryFontColor).font(.custom("Poppins-Regular", size: 16)).autocapitalization(UITextAutocapitalizationType(rawValue: 0)!)
                        } else {
                            TextField("password", text: $pass).background(Color.white).frame(width:278).foregroundColor(Constants.primaryFontColor).font(.custom("Poppins-Regular", size: 16)).autocapitalization(UITextAutocapitalizationType(rawValue: 0)!)
                        }
                        
                        Button(action: {self.hiddenPass.toggle()}) {
                            Image(systemName: !self.hiddenPass ? "eye.fill": "eye.slash.fill")
                                .foregroundColor((!self.hiddenPass) ? Color.green : Color.secondary)
                        }
                        
                    }   .padding()
                    .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.white,lineWidth:1)).background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                    
                    
                    
                    //                    Button(action: {}, label: {
                    //                        Text("Forgot password?")
                    //                            .font(.custom("Poppins-Regular", size: 13))
                    //                            .foregroundColor(Constants.primaryFontColor)
                    //                    })
                    //                    .frame(width: fieldWidth, height: CGFloat(fieldHeight!/2), alignment: .trailing)
                }
                .padding(.bottom,30)
                
//                NavigationLink(destination: MainView(model: model), tag: 1, selection: $model.canLogin){
                    Button(action: {
                        print(model.login(email: email, pass: pass))
                    }) {
                        Text("Login")
                            .font(.custom("Poppins-Regular", size: 18))
                            .foregroundColor(Color.white)
                            .fontWeight(.heavy)
                            .padding()
                            .frame(width: fieldWidth, height: fieldHeight, alignment: .center)
                            .background(Capsule().fill(Constants.primaryFontColor))
                        
                    }.padding([.leading, .trailing],30)
//                }
                
                HStack(alignment: .center, spacing: 0){
                    Text("I'm a new user. ")
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(Constants.primaryFontColor)
                    
                    Button(action: {
                        model.isSignUp.toggle()
                        model.resetQueries()
                    }) {
                        Text("Sign Up")
                            .foregroundColor(Constants.tertiaryFontColor)
                            .font(.custom("Poppins-Medium", size: 16))
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Constants.loginBackground).ignoresSafeArea()
            .fullScreenCover(isPresented: $model.isSignUp) {
                SignUpView(model: model)
            }.navigationBarHidden(true)
        }.navigationBarHidden(true)
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            LoginView(model: <#AuthenticationData#>)
//        }
//    }
//}

