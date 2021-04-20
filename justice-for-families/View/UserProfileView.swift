//
//  UserProfileView.swift
//  justice-for-families
//
//  Created by Sydney Chiang on 2/11/21.
//

import Foundation
import SwiftUI

struct profileColors{
    static let primaryColor = Color(.sRGB, red: 16/255.0, green: 83/255.0, blue: 110/255.0, opacity: 1)
    static let primaryColorOpaque = Color(.sRGB, red: 16/255.0, green: 83/255.0, blue: 110/255.0, opacity: 0.75)
    
    static let primaryColor2 = Color(.sRGB, red: 25/255.0, green: 118/255.0, blue: 157/255.0, opacity: 1)
    static let primaryColor3 = Color(.sRGB, red: 50/255.0, green: 83/255.0, blue: 98/255.0, opacity: 1)
    static let accentColor = Color(.sRGB, red: 252/255.0, green: 129/255.0, blue: 97/255.0, opacity: 1)
}

struct UserProfileView: View{
    
    var body: some View{
        NavigationView{
            ScrollView{
                UserCell()
                    .navigationBarTitle("Profile", displayMode: .inline)
                    .navigationBarItems(trailing:
                                            Button(action: {}, label: {
                                                Image(systemName: "ellipsis").font(.system(size: 16, weight: .regular))
                                            })
                    )
            }
        }
    }

}


struct UserCell: View{
    var body: some View{
        VStack{
            BioView()
            HButtonView()
            //PostView()
            
        }

    }
    
}

struct BioView : View {

    var body: some View{
        HStack{
            Image(systemName: "person.circle").font(.system(size: 90, weight: .regular))
            VStack(alignment: .leading){
                Text("John Apples")
                    .font(.custom("Poppins-Medium", size: 19))
                    .foregroundColor(profileColors.primaryColor)
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(profileColors.accentColor)
                    Text("Irvine, CA")
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(profileColors.primaryColorOpaque)
                }
                NavigationLink(destination: EditProfileView()) {
                    Text("Edit Profile")
                        .padding()
                        .frame(width:150, height: 24)
                        .background(profileColors.primaryColor2)
                        .foregroundColor(.white)
                        .cornerRadius(100)
                        
                }
               
            }
        }
    }
}

struct HButtonView : View{
    let tabs = ["Posts", "Activity"]
    @State var isPostViewToggled = true
    @State var isActivityViewToggled = false
    var body: some View{
        HStack{
            ForEach(tabs, id: \.self) { tab in
                HStack{
                    Spacer()
                    Button(action: {

                    }) {
                        Text(tab)
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(profileColors.primaryColor3)
                    }
                    Spacer()
                }

                
            }
        }.padding(.top)

    }
}

//struct ProfilePostView : View{
    //var body: some View{
        //PostView()
    //}
//}


struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

