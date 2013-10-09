package com.emote

class PopularEmote implements Comparable {
	
	private int count = 1;
	
	private final String expression;
    String goodOrBad
	

	public PopularEmote(String exp){
		expression= exp;
	}

	@Override
	public int compareTo(Object o) { 
		int compare = 1;
		if(o instanceof PopularEmote){
			PopularEmote other = o;
			compare = other.count - this.count
		}
		return compare;
	}
	
	def incrementCount(){
		count++;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
		result += expression == null ? 0 : expression.hashCode()
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PopularEmote other = (PopularEmote) obj;
		if (expression == null) {
			if (other.expression != null)
				return false;
		} else if (!expression.equalsIgnoreCase(other.expression))
			return false;
		return true;
	}
}
