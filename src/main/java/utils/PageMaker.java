package utils;

/**
 *  요청한 페이지 정보에 따라 이동 가능한 페이지 번호를 계산 및 제공하는 class
 *  ▪ 필수 정보
 *  - 사용자가 요청한 페이지 번호 : page
 *  - 한 번에 보여줄 게시물 개수 : perPageNum
 *  - 전체 게시물 개수 : totalCount
 *  - 한 페이지 블럭에 출력할 번호 개수 : displayPageCount
 */
public class PageMaker {

	/**
	 *  요청 페이지 번호
	 *  한 번에 보여줄 게시물 개수
	 *  테이블 검색 인덱스 정보를 저장하는 class
	 *  page, perPageNum, startRow
	 */
	private Criteria cri;
	
	/**
	 *  table에 저장된 전체 row 개수
	 *  전체 게시물 수
	 */
	private int totalCount;

	/**
	 *  한 페이지 블럭에 보여줄 페이지 번호 개수
	 */
	private int displayPageCount;
	
	/**
	 *  한 번에 보여줄 페이지 번호와 사용자가 요청한 페이지 번호에 따라 
	 *  화면에 출력될 페이지 블럭의 시작 페이지 번호를 저장할 field
	 */
	private int startPage;

	/**
	 *  한 번에 보여줄 페이지 번호와 사용자가 요청한 페이지 번호에 따라 
	 *  화면에 출력될 페이지 블럭의 마지막 페이지 번호를 저장할 field
	 */
	private int endPage;
	
	/**
	 *  이동 가능한 최대 페이지 번호
	 */
	private int maxPage;
	
	/**
	 *  first : 첫 번째 페이지 이동 버튼 활성화 여부
	 *  last : 마지막 페이지 이동 버튼 활성화 여부
	 *  prev : 이전 페이지 이동 버튼 활성화 여부
	 *  next : 다음 페이지 이동 버튼 활성화 여부
	 */
	private boolean first, last, prev, next;
	
	public PageMaker() {
		this(new Criteria(), 0, 5);
	}
	
	
	/**
	 *  Criteria, displayPageCount, totalCount
	 *  필드에 저장된 정보를 이용하여 페이지 블럭에 번호를 출력하기 위한 계산을 하는 method
	 *  startPage, endPagem maxPage
	 */
	public void calcPaging() {
		// 129:    129/10.0 : 12.9(올림) => 13page
		// 120:    120/10.0 : 12.0(올림) => 12page
		maxPage = (int)Math.ceil((totalCount / (double)cri.getPerPageNum()));
		
		// 마지막 페이지 번호부터 연산
		endPage = (int)Math.ceil(cri.getPage() / (double)displayPageCount) * displayPageCount;
		// displayPageCount : 5  = endPage : 5, 10, 15, 20 ... maxPage
		// displayPageCount : 10  = endPage : 10, 20, 30, 40 ... maxPage
		// displayPageCount 5일 경우 결과
		// 1page : (1/5.0) == 0.2 올림 == 1 * 5 == 5
		
		startPage = endPage - (displayPageCount - 1);
		// 			   5	- (5-1) : 1
		// 			   10	- (5-1) : 6
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 페이지 블럭 이동 버튼 활성화 여부 계산
		first = (cri.getPage() != 1) ? true : false;
		last = (cri.getPage() != maxPage) ? true : false;
		prev = (startPage != 1) ? true : false;
		next = (endPage != maxPage) ? true : false;
		
	} // end clacPaging()
	

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		if(cri == null) {
			this.cri = new Criteria();
			return;
		}
		this.cri = cri;
		// 변경된 정보로 다시 계산
		calcPaging();
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		// 변경된 정보로 다시 계산
		calcPaging();
	}

	public int getDisplayPageCount() {
		return displayPageCount;
	}

	public void setDisplayPageCount(int displayPageCount) {
		this.displayPageCount = displayPageCount;
		// 변경된 정보로 다시 계산
		calcPaging();
	}


	public PageMaker(Criteria cri, int totalCount, int displayPageCount) {
		setCri(cri);
		setTotalCount(totalCount);
		setDisplayPageCount(displayPageCount);
	}


	public int getStartPage() {
		return startPage;
	}


	public int getEndPage() {
		return endPage;
	}


	public int getMaxPage() {
		return maxPage;
	}


	public boolean isFirst() {
		return first;
	}


	public boolean isLast() {
		return last;
	}


	public boolean isPrev() {
		return prev;
	}


	public boolean isNext() {
		return next;
	}


	@Override
	public String toString() {
		return "PageMaker [cri=" + cri + ", totalCount=" + totalCount + ", displayPageCount=" + displayPageCount
				+ ", startPage=" + startPage + ", endPage=" + endPage + ", maxPage=" + maxPage + ", first=" + first
				+ ", last=" + last + ", prev=" + prev + ", next=" + next + "]";
	}

}

















