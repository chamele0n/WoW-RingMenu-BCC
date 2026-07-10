# Changelog

All notable changes to RingMenu TBC Anniversary will be documented in this file.

## Unreleased

### Fixed

- Reverted macro-specific secure attributes so RingMenu remains a normal action-bar slot view for dragging, replacing, and removing actions.
- Preserved `ACTIONBAR_SLOT_CHANGED` handling so ring buttons refresh when their mapped Blizzard action bar slots change out of combat.

## 2.5.4-Anniversary

### Changed

- Updated the addon metadata for Classic TBC Anniversary.
- Kept the expected installed addon folder name as `RingMenu`.

### Added

- Added compatibility helpers for modern addon metadata APIs, Settings panel registration, color picker behavior, addon-relative asset paths, and action button setup.

### Fixed

- Fixed ring backdrop loading when the addon is installed from a renamed source repository.
- Fixed opening the options panel on clients that use the modern Settings UI.
- Fixed ring action clicks closing the menu before the underlying action could complete.
- Added support for right-clicking ring action buttons.
