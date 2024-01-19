local MogIt,mog = ...;
local L = mog.L;

local f = mog:CreateFilter("wishlisted");
local wishlisted, notWishlisted;

f:SetHeight(41);

f.label = f:CreateFontString(nil,nil,"GameFontHighlightSmall");
f.label:SetPoint("TOPLEFT");
f.label:SetPoint("RIGHT");
f.label:SetText(L["Wishlisted items"]..":");
f.label:SetJustifyH("LEFT");

f.showWishlisted = CreateFrame("CheckButton",nil,f,"UICheckButtonTemplate");
f.showWishlisted.text:SetText(L["Items you have Wishlisted"]);
f.showWishlisted:SetPoint("TOPLEFT",f.label,"BOTTOMLEFT");
f.showWishlisted:SetScript("OnClick",function(self)
	wishlisted = self:GetChecked();
	mog:BuildList();
end);

f.showNotWishlisted = CreateFrame("CheckButton",nil,f,"UICheckButtonTemplate");
f.showNotWishlisted.text:SetText(L["Items you have not Wishlisted"]);
f.showNotWishlisted:SetPoint("TOPLEFT",f.showWishlisted,"BOTTOMLEFT");
f.showNotWishlisted:SetScript("OnClick",function(self)
	notWishlisted = self:GetChecked();
	mog:BuildList();
end);

function f.Filter(item)
	if wishlisted and notWishlisted then
		return true
	end
	if not wishlisted and not notWishlisted then
		return false
	end
	if type(item) == "table" then return end

	if wishlisted then return mog.wishlist:IsItemInWishlist((select(6, C_TransmogCollection.GetAppearanceSourceInfo(item)))); end 
	if notWishlisted then return not mog.wishlist:IsItemInWishlist((select(6, C_TransmogCollection.GetAppearanceSourceInfo(item)))); end
end

function f.Default()
	f.showWishlisted:SetChecked(true);
	f.showNotWishlisted:SetChecked(true);
	wishlisted = true;
	notWishlisted = true;
end
f.Default();
