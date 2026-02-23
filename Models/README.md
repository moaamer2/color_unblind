# Models Folder

Contains color blindness simulation and correction models.

## Available Models

- `protan/` → Protanopia model
- `deutan/` → Deuteranopia model
- `tritan/` → Tritanopia model

## Scripts

- `prepare_data.py` → Prepares images for training/testing
- `train_pix2pix.py` → Trains Pix2Pix model
- `simulate_correction.py` → Runs simulation and correction on images

## Usage

1. Prepare the dataset using `prepare_data.py`.
2. Train the model with `train_pix2pix.py`.
3. Apply correction using `simulate_correction.py`.
4. Checkpoints and results are saved automatically to Google Drive.

## Notes

- Input images should be RGB format, 256x256 (or will be resized automatically).
- Use the corresponding folder for each color deficiency type.
