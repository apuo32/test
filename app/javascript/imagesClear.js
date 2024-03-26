export const imagesClear = () => {
  document.getElementById("before-images-clear").addEventListener("click", function(){

    const obj = document.getElementById('before-images-upload');
  
    if(obj !== null){
      obj.value = '';
    }
  
    const carouselInner = document.querySelectorAll('#kaizenBeforeImagesCarousel .carousel-inner');
    carouselInner.forEach(function(item) {
      item.innerHTML = '';
    });
  
  });
  
  document.getElementById("after-images-clear").addEventListener("click", function(){
  
    const obj = document.getElementById('after-images-upload');
  
    if(obj !== null){
      obj.value = '';
    }
  
    const carouselInner = document.querySelectorAll('#kaizenAfterImagesCarousel .carousel-inner');
    carouselInner.forEach(function(item) {
      item.innerHTML = '';
    });
  
  });
};