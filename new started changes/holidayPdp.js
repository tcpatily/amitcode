var holidayContextRoot = "/tcHolidayRS/";

createApp({
    setup() {
        function getQueryParam(name) {
            if (typeof getUrlParameter === 'function') {
                return getUrlParameter(name);
            }
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(name) || '';
        }

        const packageDetailsResponse = ref([]);
        const productId = ref('');
        const isFlightDefaultMsg = ref('N'); // 'Y' or 'N'
        const tcilHolidayFlightsCollectionPopUp = ref([]); // [{ outWard: [...] }]
        const imageURL = ref('');
        const hubCollection = ref([]);
        const flightImageURL = ref('');
        const hubCollectionHp = ref([]);
        const holidayPlusSubType = ref('');

        const subType = ref();
        const tourType = ref();
        const selectedPackageClassId = ref(0)
         const payablePrice = ref(0);
         const packageId = ref("");
        // PKG012780 , PKG012817 , PKG003032

      


        async function getPackagedetails() {

            try {
                packageId.value = getQueryParam("pkgId");
                console.log("packageId", packageId.value);
                let url = holidayContextRoot + `pdp/package/${packageId.value}`;
                const response = await doAxios({ method: "get", url });
                packageDetailsResponse.value = response.data;
                window.packageDetailsResponse = packageDetailsResponse; 
                pdpSucusses();
               

            } catch (err) {
                console.error("getPackagedetails failed", err);
            }
        }
        function pdpSucusses() {
            console.log("packageDetailsResponse on load ", packageDetailsResponse.value);
            setSubType();
            console.log("packageDetailsResponse.value.packageDetail ", packageDetailsResponse.value[0].packageDetail != undefined);
            if (packageDetailsResponse.value !== undefined && packageDetailsResponse.value[0].packageDetail != undefined) {
                
                productId.value = packageDetailsResponse.value[0].packageDetail.productId;
                holidayPlusSubType.value = packageDetailsResponse.value[0].packageDetail.holidayPlusSubType;
                
                // Make data globally available for other Vue apps
                window.holidayPlusSubType = holidayPlusSubType;
                window.productId = productId;
                window.hubCollection = hubCollection;
                window.hubCollectionHp = hubCollectionHp;
                window.selectedPackageClassId = selectedPackageClassId;
                
                console.log("productId.value ", productId.value);
                console.log("holidayPlusSubType.value ", holidayPlusSubType.value);
                if (productId.value === 11) {
                    console.log("ajax call : ", holidayPlusSubType.value);
                    getHubCollectionHp(packageDetailsResponse.value[0].packageDetail.tcilHolidayLtPricingCollection);
                }
            }
        }

        async function getHubCollectionHp(ltPricing) {
            let hubs = '';
            
            // Convert Knockout array iteration to Vue.js forEach
            ltPricing.forEach(l => {
                if (l.isActive === "Y") {
                    if (hubs.length > 0) {
                        hubs += ", " + l.hubCode.cityCode;
                    } else {
                        hubs += l.hubCode.cityCode;
                    }
                }
            });

            const payload = {
                'hubs': hubs
            };
            
            try {
                const response = await doAxios({
                    method: "post",
                    data: payload,
                    headers: { "Content-Type": "application/json" },
                    url: `/tcHolidayRS/packagedetails/getHubCollectionHp`,
                });

                console.log("Hub collection populated:", response);
                if (response != undefined && response.data.length > 0) {
                    // Clear existing data before adding new data
                    hubCollectionHp.value = [];
                    response.data.forEach(hub => {
                        hubCollectionHp.value.push(hub);
                    });
                }
                console.log("Hub collection populated:", hubCollectionHp.value);
                
                // Update global variables after API response
                window.hubCollectionHp = hubCollectionHp;
            } catch (error) {
                console.error("Error occurred while fetching hub collection:", error);
            }
        }



        const sortItineraryByDay = () => {

            const itineraryArray = packageDetailsResponse.value?.[0]?.packageDetail?.tcilHolidayItineraryCollection;
            console.log(itineraryArray, "itineraryArray");

            if (Array.isArray(itineraryArray)) {
                return [...itineraryArray].sort((a, b) => a.itineraryDay - b.itineraryDay);
            }
            return [];
        };
        const sortedTimeLineCollection = () => {

            const itineraryArray = packageDetailsResponse.value?.[0]?.packageDetail?.tcilHolidayTimelineCollection;
            console.log(itineraryArray, "itineraryArray");

            if (Array.isArray(itineraryArray)) {
                return [...itineraryArray].sort((a, b) => a.position - b.position);
            }
            return [];
        };

        const sighSeeingDetailCollection = () => {
            const list = packageDetailsResponse.value?.[0]?.packageDetail?.tcilHolidaySightseeingDetailsCollection;
            if (!Array.isArray(list)) return null;

            const filteredItems = list.filter(item => item.packageClassId === selectedPackageClassId.value);
            return filteredItems.length > 0 ? filteredItems : null;
        };


        const getSightseeingByCity = () => {
            const sightseeing = sighSeeingDetailCollection();
            if (!sightseeing) return [];

            // Group by city if your data structure supports it
            // Adjust property names based on your actual data structure
            return sightseeing.tcilHolidaySightseeingCollection || [];
        };

        const setSubType = () => {
            let subId = parseInt(packageDetailsResponse.value?.[0]?.packageDetail?.pkgSubtypeId?.pkgSubtypeId);
            let mode = packageDetailsResponse.value?.[0]?.packageDetail?.tcilMode?.mode;
            if ([1, 3, 5, 6].includes(subId)) {
                subType.value = 'GIT';
                if (mode === 'TCIL') {
                    console.log(mode, "mode is tcil");
                } else {
                    hubCreation();
                }

            } else {
                subType.value = 'FIT';
                hubCreation();
            }
            // Assign tourType based on your logic
            const isCustomized = packageDetailsResponse.value?.[0]?.packageDetail?.isCustomizedHolidaysPkg;
            if ((isCustomized === true && subType.value === 'GIT') || subType.value !== 'GIT') {
                tourType.value = 'Customized Tour';
            } else {
                tourType.value = 'Group Tour';
            }

        };



        function hubCreation() {
            const priceCollection = packageDetailsResponse.value[0]?.packageDetail?.tcilHolidayPriceCollection || [];
            const currentProductId = packageDetailsResponse.value[0]?.packageDetail?.productId;

            // Helper function to get class name
            const getClassName = (packageClassId) => {
                const classId = parseInt(packageClassId);
                return classId === 0 ? 'Standard' : classId === 1 ? 'Deluxe' : 'Premium';
            };

            // Helper function to add package class if not exists
            const addPackageClassIfNotExists = (pkgClassArray, packageClassId) => {
                const classId = parseInt(packageClassId);
                const exists = pkgClassArray.some(f => f.pkgClassId === classId);
                if (!exists) {
                    pkgClassArray.push({ 
                        pkgClassId: classId, 
                        pkgClassName: getClassName(packageClassId) 
                    });
                }
            };

            priceCollection.forEach(p => {
                if (currentProductId === 11) {
                    // Holiday+ product logic
                    if (p.hubCityCode.cityCode === 'AHUB') {
                        hubCollectionHp.value.forEach(a => {
                            if (!a.pkgClass) {
                                a.pkgClass = [];
                            }
                            addPackageClassIfNotExists(a.pkgClass, p.packageClassId);
                        });
                    } else {
                        hubCollectionHp.value.forEach(b => {
                            if (b.cityCode === p.hubCityCode.cityCode) {
                                if (!b.pkgClass) {
                                    b.pkgClass = [];
                                }
                                addPackageClassIfNotExists(b.pkgClass, p.packageClassId);
                            }
                        });
                    }
                } else {
                    // Regular holiday product logic
                    let hubFound = false;
                    
                    hubCollection.value.forEach(h => {
                        if (p.hubCityCode.cityCode === h.hubCode) {
                            if (!h.pkgClass) {
                                h.pkgClass = [];
                            }
                            addPackageClassIfNotExists(h.pkgClass, p.packageClassId);
                            hubFound = true;
                        }
                    });
                    
                    // If hub not found, create new hub entry
                    if (!hubFound) {
                        const newHub = {
                            hubCode: p.hubCityCode.cityCode,
                            hubName: p.hubCityCode.cityName,
                            pkgClass: [{
                                pkgClassId: parseInt(p.packageClassId),
                                pkgClassName: getClassName(p.packageClassId)
                            }]
                        };
                        hubCollection.value.push(newHub);
                    }
                }
            });
            
            console.log("hubCollectionHp populated:", hubCollectionHp.value);
            console.log("hubCollection populated:", hubCollection.value);
        }


        const getTransfersByDayAndPackage = (day, packageClassId) => {
            const meals = packageDetailsResponse.value?.[0]?.packageDetail?.tcilHolidayTransfersDetailsCollection;
            return meals.find(transfer => transfer.day === day && transfer.packageClassId === packageClassId);
        };

        const sortByPosition = (data) => {
            return [...data].sort((a, b) => {
                if (a.position !== b.position) {
                    return a.position - b.position;
                }
                return a.day - b.day;
            });
        };

        const tcilHolidayAccomodationDetailsCollection = ref([]);
        // Computed: Sorted accommodations
        const sortedAccommodations = computed(() => {

            const data = tcilHolidayAccomodationDetailsCollection.value;
            return sortByPosition(data);
        });

        // Computed: Group into rows of 2
        const groupedRows = computed(() => {
            const rows = [];
            for (let i = 0; i < sortedAccommodations.value.length; i += 2) {
                rows.push(sortedAccommodations.value.slice(i, i + 2));
            }
            return rows;
        });


        // Method to set data (if using ref instead of props)
        const setAccommodations = () => {
            tcilHolidayAccomodationDetailsCollection.value = packageDetailsResponse.value?.[0]?.packageDetail?.tcilHolidayAccomodationDetailsCollection;
        };






        // Function to find meal by day and packageClassId
        const getMealByDayAndPackage = (day, packageClassId) => {
            const meals = packageDetailsResponse.value?.[0]?.packageDetail?.mealCollection;
            return meals.find(meal => meal.day === day && meal.packageClassId === packageClassId);
        };

        const getSightSeeingByDayAndPackage = (day, packageClassId) => {
            const meals = packageDetailsResponse.value?.[0]?.packageDetail?.tcilHolidaySightseeingDetailsCollection;
            return meals.find(meal => meal.day === day && meal.packageClassId === packageClassId);
        };
       
	   
	    const getHotelsByDayAndPackage = (day, packageClassId) => {
  const hotelsData =
    packageDetailsResponse.value?.[0]?.packageDetail?.tcilHolidayAccomodationDetailsCollection || [];
  return hotelsData.filter(
    hotel => hotel.day === day && hotel.packageClassId === packageClassId
  );
};


const getHotelImage = (hotel) => {
    const images = hotel.accomodationHotelId?.tcilMstHolidayAccomodationImageCollection;
    if (images && images.length > 0) {
      return `/images/tcHolidays/tc-PDP/${images[0].imagePath}`;
    }
    return `/images/tcHolidays/tc-PDP/building.svg`; // default image
  };

 



        
        // Function to generate meal text
        const getMealText = (day, packageClassId) => {
            const meal = getMealByDayAndPackage(day, packageClassId);
            if (!meal) return 'No meals';

            const mealTypes = [];
            if (meal.breakfast === 'Y') mealTypes.push('Breakfast');
            if (meal.packedBreakfast === 'Y') mealTypes.push('Packed Breakfast');
            if (meal.lunch === 'Y') mealTypes.push('Lunch');
            if (meal.packedLunch === 'Y') mealTypes.push('Packed Lunch');
            if (meal.dinner === 'Y') mealTypes.push('Dinner');

            return mealTypes.length > 0 ? mealTypes.join(', ') : 'No meals';
        };






        watch(groupedRows, () => console.log(groupedRows));


        watch(
            () => packageDetailsResponse.value?.[0], // or just () => packageDetailsResponse if it's a ref
            (newVal) => {
                if (newVal) {
                  
                    sortItineraryByDay();
                    sortedTimeLineCollection();
                    sighSeeingDetailCollection()
                    setAccommodations();

                    console.log(sighSeeingDetailCollection(), "sightsing datil collection")
                }
            },
            { immediate: true } // optional: triggers on initial mount
        );

        function useMeals(packageDetailsResponseRef) {
            const specialTreats = computed(() =>
                packageDetailsResponseRef.value?.[0]?.packageDetail?.specialTreats || []
            );

            const computedMeals = computed(() => {
                const meals =
                    packageDetailsResponseRef.value?.[0]?.packageDetail?.mealCollection || [];

                if (!meals.length) {
                    return {
                        totalDays: 0,
                        breakfastDays: 0,
                        lunchDays: 0,
                        dinnerDays: 0,
                        packedLunches: 0,
                        packedBreakfasts: 0,
                        daysWithoutBreakfast: [],
                        details: []
                    };
                }

                const dayMap = {};
                meals.forEach(m => {
                    if (!dayMap[m.day]) {
                        dayMap[m.day] = {
                            day: m.day,
                            breakfast: false,
                            lunch: false,
                            dinner: false,
                            packedLunch: false,
                            packedBreakfast: false
                        };
                    }
                    const d = dayMap[m.day];
                    if (m.breakfast === 'Y') d.breakfast = true;
                    if (m.lunch === 'Y') d.lunch = true;
                    if (m.dinner === 'Y') d.dinner = true;
                    if (m.packedLunch === 'Y') d.packedLunch = true;
                    if (m.packedBreakfast === 'Y') d.packedBreakfast = true;
                });

                const details = Object.values(dayMap).sort((a, b) => a.day - b.day);

                const totals = {
                    totalDays: details.length,
                    breakfastDays: 0,
                    lunchDays: 0,
                    dinnerDays: 0,
                    packedLunches: 0,
                    packedBreakfasts: 0,
                    daysWithoutBreakfast: [],
                    details
                };

                details.forEach(d => {
                    if (d.breakfast) totals.breakfastDays++;
                    else totals.daysWithoutBreakfast.push(d.day);
                    if (d.lunch) totals.lunchDays++;
                    if (d.dinner) totals.dinnerDays++;
                    if (d.packedLunch) totals.packedLunches++;
                    if (d.packedBreakfast) totals.packedBreakfasts++;
                });

                return totals;
            });

            return { computedMeals, specialTreats };
        }






        const { computedMeals, specialTreats } = useMeals(packageDetailsResponse);

        watch(
            () => packageDetailsResponse.value,
            () => {
                console.log(computedMeals.value, specialTreats.value);
            }
        )

        

        const filteredAccommodations = computed(() => {
            if (!packageDetailsResponse.value?.[0]?.packageDetail?.tcilHolidayAccomodationDetailsCollection) {
                return [];
            }

            return packageDetailsResponse.value[0]?.packageDetail?.tcilHolidayAccomodationDetailsCollection
                .filter(acc => acc.packageClassId === parseInt(selectedPackageClassId.value))
                .sort((a, b) => a.day - b.day); // Sort by day
        });


        onMounted(() => {
            getPackagedetails();

        });
        const inclusionExclusionCollection = computed(() => {
  return packageDetailsResponse.value?.[0]?.packageDetail?.tcilHolidayIncludeExcludeCollection || [];
});
        // Add ltHubCode and modifyLtHubCity function
        const ltHubCode = ref('');
        
        const modifyLtHubCity = () => {
            console.log('Hub city changed to:', ltHubCode.value);
            
            // Update session storage
            sessionStorage.setItem('hubCityCode', ltHubCode.value);
            
            // Reset package class when hub changes and auto-select first available
            let newTourTypeOptions = [];
            
            if (productId.value === 11) {
                // Holiday+ product
                if (ltHubCode.value && hubCollectionHp.value.length > 0) {
                    newTourTypeOptions = getHubCollectionHpOptions(ltHubCode.value);
                } else {
                    // Use static options based on package availability
                    newTourTypeOptions = staticTourTypeOptions.value;
                }
            } else {
                // Regular holiday product
                if (ltHubCode.value && hubCollection.value.length > 0) {
                    newTourTypeOptions = getHubCollectionOptions(ltHubCode.value);
                } else {
                    // Use static options based on package availability
                    newTourTypeOptions = staticTourTypeOptions.value;
                }
            }
            
            if (newTourTypeOptions.length > 0) {
                selectedPackageClassId.value = newTourTypeOptions[0].pkgClassId;
                console.log('Auto-selected package class:', selectedPackageClassId.value);
            } else {
                // No options available, clear selection
                selectedPackageClassId.value = '';
                console.log('No tour type options available');
            }
        };

        // Handle package class change for tour type dropdown
        const modifyPkgClass = () => {
            console.log('Package class changed to:', selectedPackageClassId.value);
            
            // Update session storage
            sessionStorage.setItem('pkgClassId', selectedPackageClassId.value);
            
            // Update payable price when tour type changes
            payablePrice.value = currentStartingPrice.value;
            
            console.log('Starting price updated:');
            console.log('- Selected Package Class:', selectedPackageClassId.value);
            console.log('- Current Starting Price:', currentStartingPrice.value);
            console.log('- Payable Price:', payablePrice.value);
        };

        // Handle select focus for label animation
        const handleSelectFocus = (event) => {
            const label = event.target.previousElementSibling;
            if (label && label.classList.contains('select_label')) {
                label.style.top = '0px';
                label.style.fontSize = '12px';
                label.style.color = '#0095da';
            }
        };

        // Handle select blur for label animation  
        const handleSelectBlur = (event) => {
            const label = event.target.previousElementSibling;
            
            if (label && label.classList.contains('select_label') && !hasValidTourType.value) {
                label.style.top = '50%';
                label.style.fontSize = '14px';
                label.style.color = '#999';
            }
        };

        // Get package class options for Holiday+ products based on selected hub
        const getHubCollectionHpOptions = (hubCode) => {
            if (!hubCode || !hubCollectionHp.value) return [];
            const selectedHub = hubCollectionHp.value.find(h => h.cityCode === hubCode);
            return selectedHub?.pkgClass || [];
        };

        // Get package class options for regular products based on selected hub
        const getHubCollectionOptions = (hubCode) => {
            if (!hubCode || !hubCollection.value) return [];
            const selectedHub = hubCollection.value.find(h => h.hubCode === hubCode);
            return selectedHub?.pkgClass || [];
        };

        // Computed properties for package class availability
        const isPackageClassStandard = computed(() => {
            return packageDetailsResponse.value?.[0]?.packageDetail?.isPackageClassStandard === 'Y';
        });

        const isPackageClassDelux = computed(() => {
            return packageDetailsResponse.value?.[0]?.packageDetail?.isPackageClassDelux === 'Y';
        });

        const isPackageClassPremium = computed(() => {
            return packageDetailsResponse.value?.[0]?.packageDetail?.isPackageClassPremium === 'Y';
        });

        // Computed properties for static tour type options (when no hub data available)
        const staticTourTypeOptions = computed(() => {
            const options = [];
            if (isPackageClassStandard.value) {
                options.push({ pkgClassId: '0', pkgClassName: 'Standard' });
            }
            if (isPackageClassDelux.value) {
                options.push({ pkgClassId: '1', pkgClassName: 'Value' });
            }
            if (isPackageClassPremium.value) {
                options.push({ pkgClassId: '2', pkgClassName: 'Premium' });
            }
            return options;
        });

        // Computed property for tour type options (for consistency with calculate price)
        const tourTypeOptions = computed(() => {
            if (productId.value === 11) {
                // Holiday+ product - get options from hubCollectionHp
                if (ltHubCode.value && hubCollectionHp.value.length > 0) {
                    return getHubCollectionHpOptions(ltHubCode.value);
                } else {
                    // Fallback to static options based on package availability
                    return staticTourTypeOptions.value;
                }
            } else {
                // Regular holiday product - get options from hubCollection
                if (ltHubCode.value && hubCollection.value.length > 0) {
                    return getHubCollectionOptions(ltHubCode.value);
                } else {
                    // Fallback to static options based on package availability
                    return staticTourTypeOptions.value;
                }
            }
        });

        // Computed property to check if a valid tour type is selected
        const hasValidTourType = computed(() => {
            const value = selectedPackageClassId.value;
            return value === '0' || value === '1' || value === '2' || 
                   value === 0 || value === 1 || value === 2;
        });

        // Computed property for current starting price based on selected package class
        const currentStartingPrice = computed(() => {
            if (!packageDetailsResponse.value?.[0]) return 0;
            
            const classId = parseInt(selectedPackageClassId.value);
            const packageData = packageDetailsResponse.value[0];
            
            if (classId === 0) {
                return packageData.startingPriceStandard || 0;
            } else if (classId === 1) {
                return packageData.startingPriceDelux || 0;
            } else if (classId === 2) {
                return packageData.startingPricePremium || 0;
            }
            
            return 0;
        });

        // Computed property for current strikeout price based on selected package class
        const currentStrikeoutPrice = computed(() => {
            if (!packageDetailsResponse.value?.[0]) return 0;
            
            const classId = parseInt(selectedPackageClassId.value);
            const packageData = packageDetailsResponse.value[0];
            
            if (classId === 0) {
                return packageData.strikeoutPriceStandard || 0;
            } else if (classId === 1) {
                return packageData.strikeoutPriceDelux || 0;
            } else if (classId === 2) {
                return packageData.strikeoutPricePremium || 0;
            }
            
            return 0;
        });

        // Computed property for discount percentage
        const discountPercentage = computed(() => {
            if (!currentStrikeoutPrice.value || !currentStartingPrice.value || currentStrikeoutPrice.value === 0) return 0;
            
            const discount = ((currentStrikeoutPrice.value - currentStartingPrice.value) / currentStrikeoutPrice.value) * 100;
            return Math.round(discount);
        });

        // Computed property to check if discount should be shown
        const shouldShowDiscount = computed(() => {
            return currentStrikeoutPrice.value > 0 && discountPercentage.value > 0;
        });

        return {
            selectedPackageClassId,
            packageDetailsResponse,
            sortItineraryByDay,
            sortedTimeLineCollection,
            sighSeeingDetailCollection,
            computedMeals,
            specialTreats,
            subType,
            tourType,
            setAccommodations,
            getMealText,
            sortByPosition,
            filteredAccommodations,
            groupedRows,
            getSightSeeingByDayAndPackage,
            hubCollection,
            hubCollectionHp,
            holidayPlusSubType,
            inclusionExclusionCollection,
            // Add the missing variables for the template
            ltHubCode,
            productId,
            modifyLtHubCity,
            modifyPkgClass,
            getHubCollectionHpOptions,
            getHubCollectionOptions,
            tourTypeOptions,
            isPackageClassStandard,
            isPackageClassDelux,
            isPackageClassPremium,
            staticTourTypeOptions,
            handleSelectFocus,
            handleSelectBlur,
            hasValidTourType,
            payablePrice,
            currentStartingPrice,
            currentStrikeoutPrice,
            discountPercentage,
            shouldShowDiscount,
            getTransfersByDayAndPackage,
            getMealByDayAndPackage,
            getHotelsByDayAndPackage,
			getHotelImage,
        };
    },
}).mount(".holiday-pdp-page");
