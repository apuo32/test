export const imagesUpload = () => {
  const beforeInput = document.getElementById('before-images-upload');
  const beforeCarouselInner = document.querySelector('#kaizenBeforeImagesCarousel .carousel-inner');

  beforeInput.addEventListener('change', function(event) {
    updateCarousel(event, beforeCarouselInner);
  });

  const afterInput = document.getElementById('after-images-upload');
  const afterCarouselInner = document.querySelector('#kaizenAfterImagesCarousel .carousel-inner');

  afterInput.addEventListener('change', function(event) {
    updateCarousel(event, afterCarouselInner);
  });

  function updateCarousel(event, carouselInner) {
    // carouselInner.innerHTML = ''; // 既存のコンテンツをクリア
    const files = event.target.files;
    Array.from(files).forEach((file, index) => {
      const reader = new FileReader();
      reader.onload = function(e) {
        const carouselItem = document.createElement('div');
        carouselItem.className = `carousel-item ${index === 0 ? 'active' : ''}`;
  
        const img = document.createElement('img');
        img.src = e.target.result;
        img.className = 'd-block carousel-img'; // カードいっぱいに表示
  
        carouselItem.appendChild(img);
        carouselInner.appendChild(carouselItem);
      };
      reader.readAsDataURL(file);
    });
  };
};