/*
 	김도은 / 멘토별 별점 평균을 저장할 class
 */

package vo;

public class RatingVO {

	private String id;
	private double score;
	
	
	public RatingVO() {
		super();
	}

	public RatingVO(String id, double score) {
		super();
		this.id = id;
		this.score = score;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	@Override
	public String toString() {
		return "RatingVO [id=" + id + ", score=" + score + "]";
	}

}
