const List<String> allCategories = [
  'For you',
  'Featured',
  'Deals',
  'Women\'s Fashion',
  'Men\'s Fashion',
  'Footwear',
  'Bags & Luggage',
  'Jewelry',
  'Toys',
  'Footwear Accessories',
  'Fabrics & Garment Accessories',
  'Leather & Accessories',
  'Mobile Gadgets & Accessories',
  'Mobile Parts & Display',
  'Computer Parts & Accessories',
  'Electrical & Electronics',
  'Machinery & Parts',
  'Tools & Hardware',
  'Packaging & Printing',
  'Furniture',
  'Chemicals',
  'Motorcycle Parts & Accessories',
  'Car Parts & Accessories',
  'Agriculture & Food',
  'Health Accessories',
  'Sports Accessories',
  'Services',
];

String getCategoryEmoji(String category) {
  switch (category) {
    case 'For you': return '🎁';
    case 'Featured': return '🌟';
    case 'Deals': return '🏷️';
    case 'Women\'s Fashion': return '👗';
    case 'Men\'s Fashion': return '👔';
    case 'Footwear': return '👟';
    case 'Bags & Luggage': return '👜';
    case 'Jewelry': return '💍';
    case 'Toys': return '🧸';
    case 'Footwear Accessories': return '🧦';
    case 'Fabrics & Garment Accessories': return '🧵';
    case 'Leather & Accessories': return '👞';
    case 'Mobile Gadgets & Accessories': return '📱';
    case 'Mobile Parts & Display': return '📲';
    case 'Computer Parts & Accessories': return '💻';
    case 'Electrical & Electronics': return '🔌';
    case 'Machinery & Parts': return '⚙️';
    case 'Tools & Hardware': return '🛠️';
    case 'Packaging & Printing': return '📦';
    case 'Furniture': return '🪑';
    case 'Chemicals': return '🧪';
    case 'Motorcycle Parts & Accessories': return '🏍️';
    case 'Car Parts & Accessories': return '🚗';
    case 'Agriculture & Food': return '🌾';
    case 'Health Accessories': return '🩺';
    case 'Sports Accessories': return '⚽';
    case 'Services': return '🤝';
    default: return '📦';
  }
}
