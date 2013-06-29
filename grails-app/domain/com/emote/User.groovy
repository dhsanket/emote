package com.emote

class User {

    static constraints = {
    }
	String id
	String firstName
	String lastName
	String email
	String facebookId
	String [] followingTopics = [];
	String profilePhotoId = ""
	boolean publishToFBWall = false
	String passcode = ""
	static hasMany = [followed:User]

}
