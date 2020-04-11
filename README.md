# JsonplaceholderAPIDemo

# 優化
* API: 以每頁每12張圖批次載入
* API Layer: 將API獨立一個class
* Infinite scroll: 可無限下拉
* Collection view batch update: 批次更新取代直接reloadData
* Image lazy loading: 延後下載圖片，會先用預設圖替代
* Cell for reuse: reuse cel前先清空重置cell
* Activity indicator: 等待API回應前，呈現載入中樣式
* End of scroll: 滾到最底會呈現結束字樣
* Transition: 縮圖開啟詳細頁面時，以自訂的轉場特效替換預設效果，到了詳細頁面下方的字延遲出現，這樣比較不突兀，另外，會先用縮圖代替，等到圖片下載完畢後再替換成正常大小圖片。
