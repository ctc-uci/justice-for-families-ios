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
           
            VStack (alignment: .center, spacing: 20) {
                Image("testLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
             
         
                VStack(alignment: .leading, spacing: -30) {
                    Text("Welcome,")
                        .padding()
                        .font(.system(size: 20, weight: .heavy))
                    Text("Sign in to continue!")
                        .padding()
                }.frame(width: fieldWidth, height: fieldHeight, alignment: .leading)

                
                VStack(alignment: .leading, spacing: 25){
                    TextField("Username",text: self.$email)
                        .padding()
                        .background(Capsule().fill(Color.white))
                        .frame(width: fieldWidth, height: fieldHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    HStack {
                        if self.hiddenPass {
                            SecureField("Password", text: self.$password)
                        } else {
                            TextField("Password", text: self.$password)
                        }
                        
                        Button(action: {self.hiddenPass.toggle()}) {
                            Image(systemName: !self.hiddenPass ? "eye.fill": "eye.slash.fill")
                                .foregroundColor((!self.hiddenPass) ? Color.green : Color.secondary)
                        } .padding([.leading], 0)
                        
                    }   .padding()
                        .frame(width: fieldWidth, height: fieldHeight, alignment: .center)
                        .background(Capsule().fill(Color.white))
                    
                }.padding([.leading, .trailing], 27.5)
                
                Button(action: {
                    Network.fetchAllPosts()
                }){
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: fieldWidth, height: fieldHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Capsule().fill(Color.gray))
                        .cornerRadius(15.0)
                }
                Button(action: {}, label: {
                    Text("Forgot password?")
                        .fontWeight(.medium)
                }).foregroundColor(.black)
                .frame(width: fieldWidth, height: CGFloat(fieldHeight!/2), alignment: .trailing)
                Spacer()
                HStack(alignment: .center, spacing: 0){
                    Text("I'm a new user. ")
                        .font(.system(size: 15))
                    NavigationLink(destination: SignUpView()){
                        Text("Join Now!")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .heavy))
                    }
                }
                Spacer()
            }.background(Constants.backgroundColor)
            .navigationBarHidden(true)
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
