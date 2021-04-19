//
//  EditProfileView.swift
//  justice-for-families
//
//  Created by Sydney Chiang on 2/26/21.
//

import Foundation
import SwiftUI

struct EditProfileView: View{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View{
        NavigationView{
            VStack{
                ProfileImgView()
                TextFieldView()
            }   
        }
        .navigationBarTitle("Edit Profile", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark").font(.system(size: 16, weight: .regular))
            },
            trailing: Text("Save")
            
        )

    }
    
}


struct ProfileImgView: View{
    var body: some View{
        VStack{
            Image(systemName: "person.circle").font(.system(size: 110, weight: .regular))
            Button(action: {
                print("working")
            }) {
                Text("Change Profile Photo")
            }

        }

    }
    
}


struct TextFieldView: View{
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var birthday = ""
    var body: some View{
        VStack{
            HStack{
                Text("Username")
                TextField("@johnnyapples", text: $username)
            }
            HStack{
                Text("Email")
                TextField("johnnyapple123@gmail.com", text: $email)
            }
            HStack{
                Text("Password")
                TextField("Password", text: $password)
            }
            HStack{
                Text("Birthday")
                TextField("Jan 1, 2002", text: $birthday)
            }
            Spacer()
        }
    }
    
}



struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}




