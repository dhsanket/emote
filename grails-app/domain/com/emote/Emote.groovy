package com.emote

class Emote {

	static constraints = {
		title blank:false
        parentTitle nullable: true
        connector nullable: true
        expressionIdeas nullable:true
	}
	static mapping = {
		topics index:true
		username index:true
		title index:true
		keywords index:true
	}
	
	String id
	String userId
	String facebookId
	User creator
	String username
	Set<String> topics = []
//	Set<String> expressions = []
	Set<String> keywords = []
	String title
    String parentTitle
    String connector
	Set<String> photos = []
    Set<ExpressionIdea> expressionIdeas = []
	// geo-location
	String locationName = ""

	//todo use joda time
	Date creationTime = new Date()
	
	public populateKeywords() {
		def k = title.toLowerCase()
		keywords.add(k)
		def u = username.toLowerCase()
		keywords.add(u)
		topics.each {topicText ->
			keywords.add(topicText.toLowerCase())
			}
	}
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Emote other = (Emote) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

    String getCompleteTitle() {
        return title + (connector?" ${connector} ":"") + (parentTitle?:"")
    }
    static embedded = ['expressionIdeas']
}