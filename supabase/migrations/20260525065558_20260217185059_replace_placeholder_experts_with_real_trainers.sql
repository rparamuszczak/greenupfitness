/*
  # Seed Experts Table with Real Trainers

  Insert real trainer data into the experts table
*/

INSERT INTO experts (specialization, name, image, overview)
VALUES 
  (
    'Personal Training & Fitness Coaching',
    'Michał Utrata',
    'https://images.pexels.com/photos/3807517/pexels-photo-3807517.jpeg',
    'Experienced personal trainer specializing in strength training and fitness coaching with proven track record of helping clients achieve their goals.'
  ),
  (
    'Fitness & Nutrition',
    'Paweł Osuch',
    'https://images.pexels.com/photos/3807517/pexels-photo-3807517.jpeg',
    'Professional fitness trainer with expertise in both training programs and nutritional guidance for optimal results.'
  ),
  (
    'Sports Performance & Training',
    'Stanisław Sitowski',
    'https://images.pexels.com/photos/3807517/pexels-photo-3807517.jpeg',
    'Sports performance specialist dedicated to enhancing athletic abilities and overall physical conditioning.'
  )
ON CONFLICT DO NOTHING;