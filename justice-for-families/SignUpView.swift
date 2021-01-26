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
