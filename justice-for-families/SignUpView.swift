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
    

    var body: some View {
        
        NavigationView {
            
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
                    SecureField("Password", text: self.$password)
                        .padding()
                        .frame(width: fieldWidth, height: fieldHeight, alignment: .center)
                        .background(Capsule().fill(Color.white))
                    SecureField("Confirm Password", text: self.$confirmPassword)
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
            }.background(Color(red: 211/255, green: 211/255, blue: 211/255))
            .navigationBarHidden(true)
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
